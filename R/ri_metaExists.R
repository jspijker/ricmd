#' Check if meta data exists
#'
#' Checks if an AVU triple allready exists in the meta data
#' of an iRODS data object
#'
#' @param object name of data object
#' @param attribute name of attribute
#' @param value value of attribute
#' @param units unit of attribute, will be NULL if not provided
#' @param collection iRODS collection where data object resides, if
#' not provided, the defaul collection will be used
#'
#' @export


ri_metaExists <- function(object,attribute,value,units=NULL,
                          collection=ri_getCollection()) {


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

    #     session <- getSession()
    #     objpath <- file.path(collection,object)
    # 
    #     obj <- session$data_objects$get(objpath)
    # 
    #     res <- try(obj$metadata$get_one(attribute),silent=TRUE)
    #     if(any(class(res)=="try-error")) {
    #         return(FALSE)
    #     } else {
    #         return(TRUE)
    #     }

    res <- avuExists(object,collection,attribute,value,units)
    return(res)

}



    

