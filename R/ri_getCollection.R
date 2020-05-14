#' Get the default IRODS collection
#'
#' This function returns the default IRODS collection set with
#' ri_setCollection.
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#' @export

ri_getCollection <- function() {

    if(!ri_testCollection()) {
        stop("collection not set")
    }


    coll <- get("collection",env=.ricmdEnv)
    return(coll)
}

