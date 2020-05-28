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
#' @export
#'
#'

ri_listSubCollections <- function(collection=NULL) {

    if(is.null(collection)) {
    cols <- getCollectionObjects()
    } else {
        if (!is.character(collection)) {
            stop("ri_listdataObjects: collection is not character")
        }
    }

    l <- getObjects(cols$subcollections,"name")
    return(l)
}


