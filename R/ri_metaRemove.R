#' Remove all meta data from a data object 
#'
#' Removes all attribute-value-unit triples from an iRODS data object
#'
#'
#' @param object name of data object
#' @param collection iRODS collection where data object resides
#'
#'
#' This function removes all AVU tripples from an iRODS object.
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#' @export



ri_metaRemove <- function(object,collection=ri_getCollection()) {

    if(!is.character(object)) {
        stop("ri_metaAdd: object is not character")
    }

    if(!is.character(collection)) {
        stop("ri_metaAdd: collection is not character")
    }

    metalst <- ri_metaGet(object,collection)

    session <- getSession()
    objpath <- file.path(collection,object)

    obj <- session$data_objects$get(objpath)
    for(i in names(metalst)) {
        obj$metadata$remove(i,metalst[[i]]$value,
                            metalst[[i]]$unit)
    }
    return()

}

