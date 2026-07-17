#' Check if meta data exists
#'
#' Checks if an AVU triple allready exists in the meta data
#' of an iRODS data object
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param value value of attribute
#' @param units unit of attribute, will be NULL if not provided
#' @param collection iRODS collection where data object resides, if not provided, the default collection will be used
#'
#' @return TRUE if AVU tripple exists, FALSE otherwise
#'
#' @export


ri_metaExists <- function(object,attribute,value,units=NULL,
                          collection=ri_getCollection()) {


    if(!is.character(object)) {
        stop("ri_metaExists: object is not character")
    }

    if(!ri_objectExists(object,collection))
        stop("ri_metaExists: object does not exists")

    if(!is.character(collection)) {
        stop("ri_metaExists: collection is not character")
    }

    if(!is.character(attribute)) {
        stop("ri_metaExists: attribute is not character")
    }

    if(!is.character(value)) {
        stop("ri_metaExists: value is not character")
    }

    if(!is.null(units)) {
        if(!is.character(units)) {
            stop("ri_metaExists: units is not character nor NULL")
        }
    }

    res <- avuExists(collection, object, attribute, value, units)
    return(res)

}



    

