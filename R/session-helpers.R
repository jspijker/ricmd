getSession <- function() {

    if(!testSession())  stop("session does not exists")
    s <- get("session",env=.ricmdEnv)
    return(s)
}


testSession <- function() {

    if(exists("session",env=.ricmdEnv)) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}

destroySession <- function() {
    if(exists(".ricmdEnv"))
        if(testSession()) 
            rm("session",pos=.ricmdEnv)
}



