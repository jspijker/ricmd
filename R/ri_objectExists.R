#' Check if data objects exists
#'
#' This function checks if an object exists in a collection. This
#' collection is either the default collection or a collection
#' specified by the collection argument.
#'
#' @param object name of the object
#' @param collection name of the collection, if not given, it uses the
#' default collection
#'
#' @return TRUE of the object exists, FALSE otherwise
#'
#' @export


ri_objectExists <- function(object, collection=ri_getCollection()) {

    if (!is.character(object)) {
        stop("ri_objectExists: object is not character")
    }

    if (!is.character(collection)) {
        stop("ri_listdataObjects: collection is not character")
    }

    session <- getSession()
    result <- session$data_objects$exists(paste0(collection, "/", object))
    return(result)
}
