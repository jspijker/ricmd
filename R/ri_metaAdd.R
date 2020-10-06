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
#' @param units unit of attribute, will be NULL if not provided
#' @param collection iRODS collection where data object resides
#'
#' iRODS uses AVU triples (attribute - value - unit) to store meta
#' data to data objects, collections users etc. This function can be
#' used to add meta data to data objects. The attribute
#' and value are obligatory. If no unit is provided, it defaults to
#' NULL.
#
#' An AVU triple must be an unique combination of attribute, value,
#' and unit. If two tripples have the same attribute, the value must
#' differ, or, if the tripples have the same attribute and value, then
#' the unit must differ. 
#'
#' If no collection argument is provided, the default collection is
#' assumed (see ri_setCollection). If the AVU tripple allready exists,
#' it is not overwritten, since the meta data is allready added to the
#' object.
#'
#' @export



ri_metaAdd <- function(object,attribute,value,collection=ri_getCollection(),
                       units=NULL) {


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

    if(!is.null(units)) {
        if(!is.character(units)) {
            stop("ri_metaAdd: units is not character nor NULL")
        }
    }

    if(!ri_collectionExists(collection)) {
        stop("ri_metaAdd: collection does not exists")
    }

    if(!ri_objectExists(object,collection)) {
        stop("ri_metaAdd: object does not exists")
    }

    
    avuStore(object,collection,attribute,value,units)
}


