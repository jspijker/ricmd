#' Starts an R - IRODS session
#'
#' This functions reads the IRODS environment file and starts and
#' IRODS session
#'
#' @param env name of IRODS environment configuration
#'
#' @return nothing
#'
#' @export


ri_session <- function(env=path.expand('~/.irods/irods_environment.json')) {

    if(!file.exists(env)) {
        stop("irods environment file not found")
    }

    irods <- import("irods.session")
    session <- irods$iRODSSession(irods_env_file = env)
    assign("session",session, envir = .ricmdEnv)
    assign("collection",NA, envir = .ricmdEnv)
    assign("datadir",NA, envir = .ricmdEnv)

}

