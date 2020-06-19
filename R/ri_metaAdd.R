#' Adds meta data (AVU triple) to iRODS data object
#'
#' Adds meta data to an iRODS data object. Meta data consists of
#' attribute - value - unit triples (AVU triples). This function only
#' adds meta data to data objects. Adding meta data to collections,
#' users etc. is not possible.
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param value value of attribute
#' @param unit unit of attribute, will be NULL if not provided
#' @param collection iRODS collection where data object resides
#' @param overwrite should attribute be overwritting if allready exists
#'
#' iRODS uses AVU triples (attribute - value - unit) to store meta
#' data to data objects, collections users etc. This function can be
#' used to add meta data to data objects. For this function attribute
#' and value are obligatory. If no unit is provided, it defaults to
#' NULL.
#'
#' If the attribute allready exists for a data object, this function
#' will result in an error, unless overwrite=TRUE
#'
#' If no collection argument is provided, the default collection is
#' assumed (see ri_setCollection).
#'
#'
#' @export



ri_metaAdd <- function(object,attribute,value,collection=ri_getCollection(),
                       unit=NULL,overwrite=FALSE) {


    if(!is.character(object)) {
        stop("ri_metaAdd: object is not character")
    }

    if(!is.character(collection)) {
        stop("ri_metaAdd: collection is not character")
    }

    if(!is.character(attribute)) {
        stop("ri_metaAdd: attribute is not character")
    }

    if(!is.character(value)) {
        stop("ri_metaAdd: value is not character")
    }

    if(!is.logical(overwrite)) {
        stop("ri_metaAdd: overwrite is not logical")
    }

    if(!is.null(unit)) {
        if(!is.character(unit)) {
            stop("ri_metaAdd: unit is not character nor NULL")
        }
    }


    if(!ri_collectionExists(collection)) {
        stop("ri_metaAdd: collection does not exists")
    }

    if(!ri_objectExists(object,collection)) {
        stop("ri_metaAdd: object does not exists")
    }

    if(ri_metaAttExists(object,attribute,collection)) {
        if(overwrite) {
            ri_metaRemoveAtt(object,attribute,collection)
        } else {
            stop("ri_metaAdd: attribute allready exists and overwrite=FALSE")
        }
    }

    if(!ri_objectExists(object)) {
        stop("ri_metaAdd: object does not exists")
    }

    
    session <- getSession()
    objpath <- file.path(collection,object)

    obj <- session$data_objects$get(objpath)
    obj$metadata$add(attribute,value,unit)

}


