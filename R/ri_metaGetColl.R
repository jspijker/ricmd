#' Get metadata for a collection
#'
#' This function retrieves all meta data, i.e. AVU triples, from an
#' iRODS collection.
#'
#' @param collection iRODS collection where data object resides
#' @param return_list Returns the metadata as list object in the
#' attribute "av" of the returned data.frame
#' @return A data.frame with three fields for attribute, value and
#' units data
#'
#' This function returns the meta data of an iRODS collection as
#' data.frame. This data.frame has 3 columns: attribute, value and
#' units, corresponding with the attribute, value, unit tripple of the
#' iRODS catalog
#'
#' If return_list is TRUE an internal representation of the meta data
#' is returned as attribute "av" of the returned data.frame.
#'
#' @export

ri_metaGetColl <- function(collection, return_list = FALSE) {

    if (!is.character(collection)) {
        stop("ri_metaGetColl: collection is not character")
    }

    if (!ri_collectionExists(collection)) {
        stop("ri_metaGetColl: collection does not exists")
    }

    if (!is.logical(return_list)) {
        stop("ri_metaGetColl: return_list is not logical")
    }

    lst <- avuGet(collection, object = NULL)
    lst.df <- avu2df(lst)

    if (return_list) {
        attr(lst.df, "av") <- list(avu = lst$avu, key = lst$key)
    }
    return(lst.df)

}
