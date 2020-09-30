
testCollection <- function() {


    coll <- get("collection",env=.ricmdEnv)
    res <- if(is.na(coll)) {
        res <- FALSE
    } else {
        res <- TRUE
    }
    return(res)

}



getCollectionObjects <- function(collection=ri_getCollection()) {
              
    session <- getSession()
    cols <- session$collections$get(collection)
    return(cols)
}


getObjects <- function(x,obj) {
    res <- unlist(lapply(x,FUN=function(x) return(x[[obj]])))
    return(res)
}


