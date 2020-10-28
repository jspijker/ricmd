#' Removes a iRODS collection
#'
#' This function removes an iRODS collection. The collection must be
#' empty. If the collection can not be removed, this function
#' generates an error.
#'
#' @param collection name of the collection to remove
#'
#' @export


ri_removeCollection <- function(collection) {

    if(!is.character(collection)) {
        stop("ri_createCollection: collection is not character")
    }


    session <- getSession()


    res <- try(coll <- session$collections$remove(collection),silent=TRUE)
    if(class(res)[1]=="try-error") {
        stop(paste0("ri_removeCollection: could not remove collection ",collection))
    }


}
