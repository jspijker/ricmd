#' Create a new IRODS collection
#'
#' This function creates a new collection in iRODS. The collection
#' must be provided with the full path. If the collection can't be
#' created, this function generates an error.
#'
#' @param collection path of new collection
#'
#' @return nothing
#'
#'
#' @export


ri_createCollection <- function(collection) {

    if(!is.character(collection)) {
        stop("ri_createCollection: collection is not character")
    }

    if(ri_collectionExists(collection)) {
        stop("ri_createCollection: collection allready exists")
    }

    session <- getSession()

    res <- try(coll <- session$collections$create(collection),silent=TRUE)
    if(class(res)[1]=="try-error") {
        stop(paste0("ri_createCollection: could not create collection ",collection))
    }

}

