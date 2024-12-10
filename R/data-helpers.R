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


