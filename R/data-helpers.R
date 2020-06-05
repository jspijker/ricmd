testDatadir <- function() {


    dd <- get("datadir",env=.ricmdEnv)
    res <- if(is.na(dd)) {
        res <- FALSE
    } else {
        res <- TRUE
    }
    return(res)

}

ri_getDatadir <- function() {
    if(!testDatadir()) {
        stop("ri_getDatadir: data directory is not set (forgot ri_setDatadir?)")
    }
    res <- get("datadir",env=.ricmdEnv)
    return(res)
}



