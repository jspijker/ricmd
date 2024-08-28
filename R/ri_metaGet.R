#' Get all meta data from an iRODS object
#'
#' This function retrieves all meta data, i.e. AVU triples, from an
#' iRODS data object. 
#'
#'
#' @param object name of data object
#' @param collection iRODS collection where data object resides
#' @param return_list Returns the metadata as list object
#'
#' @return A data.frame with three fields for attribute, value and
#' units data
#'
#' This function returns the meta data of an iRODS data object as
#' data.frame. This data.frame has 3 columns: attribute, value and
#' units, corresponding with the attribute, value, unit tripple of the
#' iRODS catalog
#'
#' It return_list is TRUE an internal representation of the meta data
#' is returned as attribute
#'
#' @export

ri_metaGet <- function(object, collection=ri_getCollection(),
                       return_list = FALSE) {


    if(!is.character(object)) {
        stop("ri_metaGet: object is not character")
    }

    if(!is.character(collection)) {
        stop("ri_metaGet: collection is not character")
    }

    if(!is.logical(return_list)) {
        stop("ri_metaGet: return_list is not logical")
    }

    if(!ri_objectExists(object,collection)) {
        stop("ri_metaGet: object does not exists")
    }

    lst <- avuGet(object,collection)
    lst.df <- avu2df(lst)

    if (return_list) {
        attr(lst.df, "av") <- list(avu = lst$avu, key = lst$key)
    }
    return(lst.df)

}
