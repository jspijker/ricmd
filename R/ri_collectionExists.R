#' Test if collection exists
#'
#' This function test if a collection exists. The collection must be
#' given as full path of the collection.
#'
#' @param collection name of the collection
#'
#' @return TRUE if collection exists, FALSE otherwise
#'
#' @export
#'


ri_collectionExists <- function(collection) {


    if(!testSession()) {
        stop("ri_collectionExists: session does not exists")
    }

    if(!is.character(collection))  {
        stop("ri_collectionExists: name is not character")
    }
    session <- getSession()

    res <- try(coll <- session$collections$get(collection),silent=TRUE)
    if(class(res)[1]=="irods.collection.iRODSCollection") {
        result <- TRUE
    } else {
        result <- FALSE
    }

    return(result)

}

