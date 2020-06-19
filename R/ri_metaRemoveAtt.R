#' Remove attribute from a data object 
#'
#' Removes an attribute - value - unit tripple from the meta data of
#' an iRODS object
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param collection iRODS collection where data object resides
#'
#' This function removes an attribute - value - unit (AVU) tripple
#' from an iRODS data object. Only the name of the attribute must be
#' supplied. It will be silently ignored if the attribute does not
#' exist
#'
#'
#' @export


ri_metaRemoveAtt <- function(object,attribute,collection=ri_getCollection()) {

    if(!is.character(object)) {
        stop("ri_metaAdd: object is not character")
    }

    if(!is.character(collection)) {
        stop("ri_metaAdd: collection is not character")
    }

    if(!is.character(attribute)) {
        stop("ri_metaAdd: attribute is not character")
    }

    if(!ri_metaAttExists(object,attribute)) {
        return()
    }

    metalst <- ri_metaGet(object,collection)
    meta <- metalst[[attribute]]

    session <- getSession()
    objpath <- file.path(collection,object)

    obj <- session$data_objects$get(objpath)
    obj$metadata$remove(attribute,meta$value,
                        meta$unit)
    return()

}

