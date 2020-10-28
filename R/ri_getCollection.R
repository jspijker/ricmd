#' Get the default IRODS collection
#'
#' This function returns the default IRODS collection set with
#' \code{\link{ri_setCollection}}.
#'
#' This function doesn't have any arguments
#' @return A string with the name of the default iRODS collection
#'
#' @details
#'
#'
#' This package uses a default collection, which you must set manually
#' with \code{\link{ri_setCollection}}.
#' If you manipulate (store/retrieve etc) your data objects, it is assumed
#' that they exists in this default collection, unless you provide a specific
#' collection in the function arguments.
#'
#' Many functions in the ricmd package will call this function if no
#' collection is provided as argument to these functions. This is
#' shortcut to prevent that the user must provide the full path of the
#' collection each time the user manipulates a data object.
#'
#' @export

ri_getCollection <- function() {

    if (!testCollection()) {
        stop("collection not set")
    }


    coll <- get("collection", envir = .ricmdEnv)
    return(coll)
}

