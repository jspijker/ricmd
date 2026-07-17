#' Remove a metadata attribute-value-unit (AVU) triple from a
#' collection in iRODS.
#'
#' This function removes an AVU triple from the metadata of an iRODS
#' collection. It takes the collection name, attribute, value, and
#' optionally units as input parameters. If the specified AVU triple
#' exists in the collection's metadata, it will be removed.
#'
#' @param collection The name of the iRODS collection from which to
#' remove the metadata.
#' @param attribute The name of the metadata attribute to remove.
#' @param value The value of the metadata attribute to remove.
#' @param units (Optional) The units associated with the metadata
#' attribute. If not provided, it defaults to NULL.
#' @return This function does not return any value. It performs the
#' removal operation and returns invisibly.
#'
#' @details
#' The function first checks if the specified collection exists in
#' iRODS. If the collection does not exist, an error is raised. It
#' also validates the input parameters to ensure they are of the correct
#' types. If the AVU triple exists in the collection's metadata, it is
#' removed using the `avuRemove` function. If the AVU triple does not
#' exist, no action is taken.
#'
#' @export

ri_metaRemoveColl <- function(collection, attribute, value, units = NULL) {

    if (!ri_collectionExists(collection))
        stop("ri_metaRemoveColl: object does not exists")

    if (!is.character(collection)) {
        stop("ri_metaRemoveColl: collection is not character")
    }

    if (!is.character(attribute)) {
        stop("ri_metaRemoveColl: attribute is not character")
    }

    if (!is.character(value)) {
        stop("ri_metaRemoveColl: value is not character")
    }

    if (!is.null(units)) {
        if(!is.character(units)) {
            stop("ri_metaRemoveColl: units is not character nor NULL")
        }
    }

    avuRemove(collection, object = NULL, attribute,value,units)
    return()

}
