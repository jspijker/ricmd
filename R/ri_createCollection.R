#' Create a new IRODS collection
#'
#' Create a new collection wihtin an existing collection.
#'
#' @param collection name of new collection
#'
#' @return nothing
#'
#'
#' This function creates a new collection (subcollection) within an
#' existing collection. 
#'
#' @export
#'
#'


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

