#' Delete a data object 
#'
#' Remove a data object from an iRODS collection. If
#' the data object does not exists, it will be silently ignored
#'
#' @param object name of the object
#' @param collection collection of the object, if no collection is provided it uses the default collection
#'
#' @return nothing
#'
#' @export

ri_rm <- function(object,collection=ri_getCollection()) {

    if(!is.character(object)) {
        stop("ri_rm: object is not character")
    }
    if(!is.character(collection)) {
        stop("ri_rm: collection is not character")
    }


    session <- getSession()
    objpath <- file.path(collection,object)

    if(ri_objectExists(object,collection)) {
        obj <- session$data_objects$unlink(objpath)
    }



}
