######################################################################
# Helper function for session management
######################################################################

getSession <- function() {
    # get session object

    if(!testSession())  stop("session does not exists")
    s <- get("session",env=.ricmdEnv)
    return(s)
}


testSession <- function() {
    # test if session object exist

    if(exists("session",env=.ricmdEnv)) {
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



