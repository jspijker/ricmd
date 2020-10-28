######################################################################
# Helper functions for local data directory
######################################################################

testDatadir <- function() {
    # test if local data directory exists


    dd <- get("datadir", envir = .ricmdEnv)
    res <- if(is.na(dd)) {
        res <- FALSE
    } else {
        res <- TRUE
    }
    return(res)

}

ri_getDatadir <- function() {
    # get name of data directory
    if(!testDatadir()) {
        stop("ri_getDatadir: data directory is not set (forgot ri_setDatadir?)")
    }
    res <- get("datadir", envir = .ricmdEnv)
    return(res)
}



