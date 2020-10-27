#' Store data object in iRODS collection
#'
#' Stores a data object in a iRODS collection. If the data object
#' allready exists, it is not overwritten by default
#'
#' @param filename filename or path of file to store
#' @param collection name of the collection where to store the data, if not provided it uses the default collection
#' @param object name of the data object, defaults to the basename of the path given by the file argument
#' @param overwrite overwrite existing data objects, default to FALSE
#'
#' @export


ri_put <- function (filename,collection=NULL, object=NULL,overwrite=FALSE) {

    if(!is.character(filename)) {
        stop("ri_put: filename is not character")
    }

    if(is.null(collection)) {
        collection <- ri_getCollection()
    }

    if(!is.character(collection)) {
        stop("ri_put: collection is not character")
    }

    if(is.null(object)) {
        object <- basename(filename)
    }
    
    if(!is.character(object)) {
        stop("ri_put: name is not character")
    }

    if(!is.logical(overwrite)) {
        stop("ri_put: overwrite is not logical")
    }

    session <- getSession()
    objpath <- paste0(collection,"/",object)
    if(ri_objectExists(object,collection) && !overwrite) {
        stop("ri_put: object allready exists and overwrite is FALSE")
    }

    session$data_objects$put(filename,objpath)


}
