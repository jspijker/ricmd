#' Check if meta data attribute allready exists
#'
#' Checks if an attribute value allready exists in the meta data (AVU
#' triples) of an iRODS data object
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param collection iRODS collection where data object resides
#'
#'
#'
#'
#'
#'
#'
#' @export


ri_metaAttExists <- function(object,attribute,collection=ri_getCollection()) {

    if(!is.character(object)) {
        stop("ri_metaAdd: object is not character")
    }

    if(!is.character(attribute)) {
        stop("ri_metaAdd: attribute is not character")
    }

    if(!is.character(collection)) {
        stop("ri_metaAdd: collection is not character")
    }

    if(!ri_objectExists(object)) {
        stop("ri_metaAdd: object does not exists")
    }


    session <- getSession()
    objpath <- file.path(collection,object)

    obj <- session$data_objects$get(objpath)

    res <- try(obj$metadata$get_one(attribute),silent=TRUE)
    if(any(class(res)=="try-error")) {
        return(FALSE)
    } else {
        return(TRUE)
    }


}



    

