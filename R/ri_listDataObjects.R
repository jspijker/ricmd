#' List data objects wihtin a collection
#'
#' Provides a list of all data objects within a collection. The
#' collection is either the default collection or a collection
#' specfied by argument.
#'
#' @param collection name of the collection, if not provided, then
#' this will be the default collection.
#'
#' @return character vector with names of dataobjects
#'
#' @details
#' see \code{\link{ri_setCollection}} for how to set the default
#' collection.
#'
#' @export

ri_listDataObjects <- function(collection=ri_getCollection()) {

    if (!is.character(collection)) {
        stop("ri_listdataObjects: collection is not character")
    }

    cols <- getCollectionObjects(collection)
    l <- getObjects(cols$data_objects,"name")
    return(l)
}


