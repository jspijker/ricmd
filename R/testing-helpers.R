#' ricmd test function, check docker
#'
#' The ri_test_... functions are meant for package testing and setting
#' up a demo environment. These functions are not intended for package
#' users.
#' Checks if a docker environment exists
#'
#' @param verbose Give verbose output
#'
#' Check if Docker is installed and can be accessed without sudo
#' rights.
#'
#' Function copied from rirods package, https://github.com/irods/irods_client_library_rirods, Martin Schobben
#'
#' @export


ri_test_check_docker <- function(verbose = FALSE) {
    # Function copied from rirods package,
    # https://github.com/irods/irods_client_library_rirods, Martin
    # Schobben
    #
    # check if Docker is installed and can be accessed without sudo rights
    docker_version <- system("docker --version", ignore.stdout = !verbose,
                             ignore.stderr = !verbose)
    !(Sys.which("bash") == "" || Sys.which("docker") == "" || docker_version == "")
}


#' ricmd test function, test valid ip
#'
#' The ri_test_... functions are meant for package testing and setting
#' up a demo environment. These functions are not intended for package
#' users.
#' Checks if a ip address is valid
#'
#' @param ip ip address as character
#'
#' @export

ri_test_valid_ip <- function(ip) {

    ip_pattern <- "^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    res <- grepl(ip_pattern, ip)
    return(res)
}


#' ricmd test function, get catalog provider ip
#'
#' The ri_test_... functions are meant for package testing and setting
#' up a demo environment. These functions are not intended for package
#' users.
#' looks up the ip of the iRODS catalog provider
#'
#' @param verbose Be verbose
#'
#' @export

ri_test_get_catalog_provider_ip <- function(verbose = FALSE) {


    # check irods grid, get ip
    catalog_provider <- "irods_demo-irods-catalog-provider-1"

    docker_cmd <- "docker"
    docker_args <- paste("inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}'",
                         catalog_provider)

    suppressWarnings(
                     result <- try(irods_ip <- system2(docker_cmd, args = docker_args, 
                                                       stdout = TRUE, stderr = NULL))
    )

    if (class(result) == "try-error") {
        stop("ERROR in docker command\n")
    }

    if (!ri_test_valid_ip(irods_ip)) {
        stop("ERROR, no docker irods catalog provider found")
    } else {
        if (verbose) cat("found irods catalog provider at", irods_ip, "\n")
    }
    return(irods_ip)
}


#' ricmd test function, checks if iRODS auth file exists
#'
#' The ri_test_... functions are meant for package testing and setting
#' up a demo environment. These functions are not intended for package
#' users.
#' Checks if an iRODS auth file exists
#'
#' @param irods_dir iRODS configuration dir, defailts ~/.irods
#'
#' @export

ri_test_auth_file_exists <- function(irods_dir = path.expand("~/.irods")) {

    auth_file <- file.path(irods_dir, ".irodsA")
    res <- file.exists(auth_file)
    return(res)
}


#' ricmd test function, creates dummy auth file
#'
#' The ri_test_... functions are meant for package testing and setting
#' up a demo environment. These functions are not intended for package
#' users.
#' creates a dummy auth file
#'
#' @param irods_dir iRODS configuration dir, defailts ~/.irods
#' @param verbose Be verbose
#'
#' Due to some quirk in the iRODS python library, an auth file must
#' exist othewrwise a non interactive connection is not possible
#'
#' @export

ri_test_create_auth_file <- function( irods_dir = path.expand("~/.irods"),
                             verbose = TRUE) {

    auth_file <- file.path(irods_dir, ".irodsA")

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

#' ricmd test function, creates demo environment file
#'
#' The ri_test_... functions are meant for package testing and setting
#' up a demo environment. These functions are not intended for package
#' users.
#' creates a demo environment file
#'
#' @param irods_dir iRODS configuration dir, defailts ~/.irods
#' @param verbose Be verbose
#'
#' This function creates an environment file to connect to the
#' irods_demo Docker clusters
#'
#' @export

ri_test_create_demo_env <- function(irods_ip) {

    if(!is.character(irods_ip)) {
        stop("create_demo_env: ip must be character")
    }
    if (!ri_test_valid_ip(irods_ip)) {
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


#' ricmd test function, creates demo environment file
#'
#' The ri_test_... functions are meant for package testing and setting
#' up a demo environment. These functions are not intended for package
#' users.
#' tests if iRODS session object is valid
#'
#' @param session iRODS session object
#'
#' An valid session object contains an iRODS connection. This function
#' tests if a username is present for a connection. If so, the
#' connection is considered valid and the function returns TRUE
#'
#' @export


ri_test_valid_session <- function(session) {
    result <- tryCatch(sess <- session$users$get(session$username),
                       error = function(e) NULL)
    res <- !is.null(result)
    return(res)
}


