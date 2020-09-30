#' List data objects wihtin collection
#'
#' Provides a list of all data objects within a collection. The
#' collection is either the default collection or a collection
#' specfied by argument
#'
#' @param collection if NULL this is the default collection, either
#' the name of the collection to list the dataobjects
#'
#' @return character vector with names of dataobjects
#'
#' @export
#'
#'

ri_listDataObjects <- function(collection=ri_getCollection()) {

    if (!is.character(collection)) {
        stop("ri_listdataObjects: collection is not character")
    }

    cols <- getCollectionObjects(collection)
    l <- getObjects(cols$data_objects,"name")
    return(l)
}


