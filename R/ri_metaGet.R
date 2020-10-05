#' Get all meta data from an iRODS object
#'
#' This function retrieves all meta data, i.e. AVU triples, from an
#' iRODS data object
#'
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param collection iRODS collection where data object resides
#'
#' This function returns a list with the meta data of an iRODS data
#' object (AVU triple). The first level in the list are the
#' attributes, each attribute in the list is a list with the value and
#' unit.
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
