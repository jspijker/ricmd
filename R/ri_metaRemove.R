#' Remove meta data from an object
#'
#' Removes an Attribute-Value-Units (AVU) triple from an object
#'
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param value value of attribute
#' @param units unit of attribute, will be NULL if not provided
#' @param collection iRODS collection where data object resides, if
#' not provided, the defaul collection will be used
#'
#' This function removes an AVU tripple from an iRODS object.
#'
#' @export



ri_metaRemove <- function(object,attribute,value,collection=ri_getCollection(),
                          units=NULL) {

    if(!is.character(object)) {
        stop("ri_metaRemove: object is not character")
    }

    if(!ri_objectExists(object,collection))
        stop("rmetaRemovei_metaAdd: object does not exists")

    if(!is.character(collection)) {
        stop("rmetaRemovei_metaAdd: collection is not character")
    }

    if(!is.character(attribute)) {
        stop("rmetaRemovei_metaAdd: attribute is not character")
    }

    if(!is.character(value)) {
        stop("rmetaRemovei_metaAdd: value is not character")
    }

    if(!is.null(units)) {
        if(!is.character(units)) {
            stop("rmetaRemovei_metaAdd: units is not character nor NULL")
        }
    }


    avuRemove(object,collection,attribute,value,units)
    return()

}

