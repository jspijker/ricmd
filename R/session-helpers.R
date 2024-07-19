######################################################################
# Helper function for session management
######################################################################

getSession <- function() {
    # get session object

    if(!testSession())  stop("session does not exists")
    s <- get("session", envir = .ricmdEnv)
    return(s)
}


testSession <- function() {
    # test if session object exist

    if(exists("session", envir = .ricmdEnv)) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}

destroySession <- function() {
    # destroy session object

    if(exists(".ricmdEnv"))
        if(testSession()) 
            rm("session",pos=.ricmdEnv)
}

is_valid_session <- function(session) {
    result <- tryCatch(sess <- session$users$get(session$username),
                       error = function(e) NULL)
    res <- !is.null(result)
    return(res)
}



