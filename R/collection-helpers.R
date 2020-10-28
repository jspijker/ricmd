######################################################################
# These are internal helper functions for operations with iRODS
# collections
######################################################################

testCollection <- function() {
    # test if default collection is set (e.g. using ri_setCollection)

    coll <- get("collection", envir = .ricmdEnv)
    res <- if(is.na(coll)) {
        res <- FALSE
    } else {
        res <- TRUE
    }
    return(res)

}



getCollectionObjects <- function(collection=ri_getCollection()) {
    # get all subcollections within a collection
              
    session <- getSession()
    cols <- session$collections$get(collection)
    return(cols)
}


getObjects <- function(x,obj) {
    # unlist function for a data_objects object
    res <- unlist(lapply(x,FUN=function(x) return(x[[obj]])))
    return(res)
}


