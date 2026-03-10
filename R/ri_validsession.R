#' Check for a valid iRODS session
#' 
#' This function checks if a valid iRODS session is present in the
#' ricmd environment. A session is valid if it contains 
#' connection info to an iRODS server.
#' 
#' @return TRUE if a valid session is found, otherwise an error is
#' raised
#' @export


ri_validsession <- function() {


    session <- get("session",env=.ricmdEnv)
    res <- ri_test_valid_session(session)
    if(!res) {
        stop("no valid iRODS session found")
    }
    return(TRUE)
}
