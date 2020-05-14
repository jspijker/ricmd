#' Removes a iRODS collection
#'
#' This function removes an iRODS collection
#'
#' @param collection name of the collection to remove
#'
#' This function removes an collection
#'
#'
#'
#' @export
#'
#'
#'


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
