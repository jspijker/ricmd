#' Test if collection exists
#'
#' Test if a collection allready exists
#'
#' @param collection name of new collection
#'
#' @return TRUE if collection exists, FALSE otherwise
#'
#'
#' This function test of a collection (subcollection) exists within an
#' existing collection. 
#'
#' @export
#'
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

