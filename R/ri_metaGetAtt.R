#' Get specific attribute from data object
#'
#' Gets an attribute - value -unit triple from the meta data
#' of an iRODS data object
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param collection iRODS collection where data object resides
#'
#' This function retrieves an specific attribute - value -unit (AVU) tripple
#' from an iRODS data object based on the attribute name.  
#'
#'
#'
#' @export


ri_metaGetAtt <- function(object,attribute,collection=ri_getCollection()) {


    if(!is.character(object)) {
        stop("ri_metaGet: object is not character")
    }

    if(!is.character(collection)) {
        stop("ri_metaGet: collection is not character")
    }

    if(!ri_objectExists(object)) {
        stop("ri_metaGet: object does not exists")
    }



    metalst <- ri_metaGet(object,collection)
    att <- metalst[[attribute]]
    return(att)

}
