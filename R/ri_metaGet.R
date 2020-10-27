#' Get all meta data from an iRODS object
#'
#' This function retrieves all meta data, i.e. AVU triples, from an
#' iRODS data object. 
#'
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param collection iRODS collection where data object resides
#'
#' @return A data.frame with three fields for attribute, value and units data
#'
#'
#'
#'
#' @export

ri_metaGet <- function(object, collection=ri_getCollection()) {


    if(!is.character(object)) {
        stop("ri_metaGet: object is not character")
    }

    if(!is.character(collection)) {
        stop("ri_metaGet: collection is not character")
    }

    if(!ri_objectExists(object)) {
        stop("ri_metaGet: object does not exists")
    }

    lst <- avuGet(object,collection)
    lst.df <- avu2df(lst)

    return(lst.df)

}
