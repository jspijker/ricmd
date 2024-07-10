######################################################################
# ricmd tests
######################################################################
# This is the setup script for the ricmd testing framework. Tests
# needs the irods_demo server (see
# https://github.com/irods/irods_demo)


######################################################################
# functions
######################################################################

check_docker <- function(verbose = FALSE) {
    # Function copied from rirods package,
    # https://github.com/irods/irods_client_library_rirods, Martin
    # Schobben
    #
    # check if Docker is installed and can be accessed without sudo rights
    docker_version <- system("docker --version", ignore.stdout = !verbose,
                             ignore.stderr = !verbose)
    !(Sys.which("bash") == "" || Sys.which("docker") == "" || docker_version == "")
}

valid_ip <- function(ip) {

    ip_pattern <- "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    res <- grepl(ip_pattern, ip)
    return(res)
}

get_catalog_provider_ip <- function(verbose = TRUE) {


    # check irods grid, get ip
    catalog_provider <- "irods-demo-irods-catalog-provider-1"

    docker_cmd <- "docker"
    docker_args <- paste("inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'",
                         catalog_provider)

    suppressWarnings(
                     result <- try(irods_ip <- system2(docker_cmd, args = docker_args, 
                                                       stdout = TRUE, stderr = NULL))
    )

    if(class(result) == "try-error") {
        stop("ERROR in docker command\n")
    }

    #res <- grepl(ip_pattern, irods_ip)
    if(!valid_ip(irods_ip)) {
        stop("ERROR, no docker irods catalog provider found")
    } else {
        if (verbose) cat("found irods catalog provider at", irods_ip, "\n")
    }
    return(irods_ip)
}

auth_file_exists <- function() {
    irods_dir <- path.expand("~/.irods")
    auth_file <- file.path(irods_dir, ".irodsA")
    res <- file.exists(auth_file)
    return(res)
}

create_auth_file <- function(verbose = TRUE) {

    if(!dir.exists(irods_dir)) {
        if (verbose) cat("irods directory ~/.irods not found, creating ...\n")
        dir.create(irods_dir)
    }

    if(!file.exists(auth_file)) {
        if (verbose) cat("irodsA auth file not found, creating ...\n")
        fconn <- file(auth_file)
        writeLines(".%+90ze*M08E8(#028LED2", fconn)
        close(fconn)
    } else {
        if (verbose) cat("using existsing irodsA auth file\n")
    }

}

is_valid_session <- function(session) {
    result <- tryCatch(sess <- session$users$get(session$username),
                       error = function(e) NULL)
    res <- !is.null(result)
    return(res)
}

create_demo_env <- function(irods_ip) {

    if(!is.character(irods_ip)) {
        stop("create_demo_env: ip must be character")
    }
    if (!valid_ip(irods_ip)) {
        stop("create_demo_env: no valid ip provided")
    }

    irods_env <- list(irods_host = irods_ip,
                      irods_user_name = "rods",
                      irods_password = "rods",
                      irods_port = 1247,
                      irods_zone_name = "tempZone")

    f <- jsonlite::toJSON(irods_env, auto_unbox = TRUE, pretty = TRUE)

    irods_env_f  <- file.path(tempdir(), "irods_environment.json")
    jsonlite::write_json(x = irods_env, 
               path = irods_env_f,
               auto_unbox = TRUE,
               pretty = TRUE)

    return(irods_env_f)
}




######################################################################
# Test objects
######################################################################

default.lst <- list(avu=list(list(attribute="key1",value="val1",units="unit1"),
                   list(attribute="key2",value="val2",units=NA)),
          key=list(key1=1,key2=2))



######################################################################
# Start
######################################################################



cat("running setup ...")


if (!check_docker()) {
    stop("Docker binary not found")
}

irods_ip <- get_catalog_provider_ip()
if (!auth_file_exists()) create_auth_file()
env <- create_demo_env(irods_ip)

irods <- import("irods.session")
session <- irods$iRODSSession(irods_env_file=env)

if (!is_valid_session(session)) {
    stop("No valid iRODS session")
} else {
    cat("iRODS session is valid\n")
}

testColl <- file.path("",session$zone,'home',session$username,"tests")
session$collections$create(testColl)
rm(session)

testDatadir <- file.path(tempdir(),'data')
if(!dir.exists(testDatadir)) {
    dir.create(testDatadir)
}

# create Test list

cat("Done!\n")

