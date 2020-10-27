#' List subcollections wihtin a collection
#'
#' Provides a list of all subcollections within a collection. The
#' collection is either the default collection or a collection
#' specfied by argument
#'
#' @param collection if NULL this is the default collection, either
#' the name of the collection to list the dataobjects
#'
#' @return character vector with names of subcollections
#'
#' @details
#' see \code{\link{ri_setCollection}} for how to set the default
#' collection.
#'
#' @export

ri_listSubCollections <- function(collection=NULL) {

    if(is.null(collection)) {
        collection <- ri_getCollection()
    } else {
        if (!is.character(collection)) {
            stop("ri_listSubCollections: collection is not character")
        }
    }

    cols <- getCollectionObjects(collection)
    l <- getObjects(cols$subcollections,"name")
    return(l)
}


