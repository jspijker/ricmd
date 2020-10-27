#' Get object from iRODS collection
#'
#' Get an object from an iRODS collection. If no collection is given,
#' it uses the default collection.
#'
#' @param object name of data object
#' @param collection iRODS collection where data object resides
#' @param datadir the local directory where to store the retrieved
#' data object
#' @param filename filename of retrieved data object
#' @param overwrite should file be overwritting if allready exists
#'
#' @return nothing
#'
#' @details
#'
#' This function retrieves a data object from an iRODS collection. The
#' default behaviour is to get the object from the default collection
#' (see \code{\link{ri_setCollection}})  and store it in the local data directory
#' (see \code{\link{[ri_setDatadir}} ) using the data object's name as filename.
#' Using the arguments collection, datadir, and filename it is
#' possible to override this default behaviour.
#'
#' A file is not overwritten if it allready exists in the data
#' directory, use the overwrite argument to force writing of the file.
#' If the file exists and overwrite=FALSE, then this function will
#' generate an error
#'
#' @export

ri_get <- function(object,collection=ri_getCollection(),
                   datadir=ri_getDatadir(),filename=object,
                   overwrite=FALSE) {

    if(!is.character(object)) {
        stop("ri_get: object is not character")
    }

    if(!is.character(collection)) {
        stop("ri_get: collection is not character")
    }

    if(!ri_collectionExists(collection)) {
        stop("ri_get: collection does not exists")
    }

    if(!ri_objectExists(object,collection)) {
        stop("ri_get: object does not exists")
    }

    if(!is.character(datadir)) {
        stop("ri_get: datadir is not character")
    }

    if(!is.character(filename)) {
        stop("ri_get: filename is not character")
    }

    if(!is.logical(overwrite)) {
        stop("ri_get: overwrite is not logical")
    }


    objpath <- file.path(collection,object)
    fname <- file.path(datadir,filename)
    if(file.exists(fname)) {
        if(overwrite) {
            unlink(fname)
        } else {
            stop("ri_get: file allready exists in data directory and overwrite=FALSE")
        }
    }
    obj <- session$data_objects$get(objpath,fname)




}
