#' Check if data objects exists
#'
#' Check if a data object exists in the default collection or in a
#' given collection.
#'
#' @param object name of object
#' @param collection name of collection, if not given, it uses the
#' default collection
#'
#' @return TRUE of the object exists, FALSE otherwise
#'
#'
#' This function checks if an object exists in a collection. This
#' collection is either the default collection of a collection
#' specified by the collection argument
#'
#'
#'
#' @export
#'


ri_objectExists <- function(object,collection=NULL) {

    if(!is.character(object)) {
        stop("ri_objectExists: object is not character")
    }

    if(is.null(collection)) {
        collection <- ri_getCollection()
    } else {
        if (!is.character(collection)) {
            stop("ri_listdataObjects: collection is not character")
        }
    }

    session <- getSession()
    result <- session$data_objects$exists(paste0(collection,"/",object))
    return(result)
}

