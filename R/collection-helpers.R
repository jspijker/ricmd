
testCollection <- function() {


    coll <- get("collection",env=.ricmdEnv)
    res <- if(is.na(coll)) {
        res <- FALSE
    } else {
        res <- TRUE
    }
    return(res)

}

