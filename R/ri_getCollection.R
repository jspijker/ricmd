#' Get the default IRODS collection
#'
#' This function returns the default IRODS collection set with
#' ri_setCollection.
#'
#' This function doesn't have any arguments
#'
#' @export

ri_getCollection <- function() {

    if(!testCollection()) {
        stop("collection not set")
    }


    coll <- get("collection",env=.ricmdEnv)
    return(coll)
}

