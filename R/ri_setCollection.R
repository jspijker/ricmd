#' Set the default collection
#'
#' This functions sets the default collection for the user
#'
#' @param collection path to the default IRODS collection
#' 
#' @details
#' 
#' Many function in this package use the default collection for
#' storing and retrieving data objects. The default collection must be
#' set by the user after the initialisation of the IRODS session with
#' \code{\link{ri_session}}.
#'
#' @export



ri_setCollection <- function(collection) {

    if(!is.character(collection)) {
        stop("collection is not character")
    }

    if(!testSession()) {
        stop("ri_setcollection: session does not exists")
    }

    session <- getSession()

    res <- try(coll <- session$collections$get(collection),silent=TRUE)
    if(class(res)[1]=="try-error") {
        stop("ri_setcollection: collection does not exist")
    }

    assign("collection", collection, envir = .ricmdEnv)

}

