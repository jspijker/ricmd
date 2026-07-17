#' Check if a metadata attribute exists for a collection
#'
#' Checks if an AVU triple already exists in the metadata of an iRODS
#' collection
#'
#' @param collection name of the iRODS collection
#' @param attribute name of the metadata attribute
#' @param value value of the metadata attribute
#' @param units (Optional) unit of the metadata attribute, will be NULL if not provided
#' @return TRUE if the AVU triple exists, FALSE otherwise
#'
#' @details
#' This function checks if a specific Attribute-Value-Units (AVU)
#' triple exists in the metadata of an iRODS collection. It takes the
#' collection name, attribute, value, and optionally units as input
#' parameters. If the specified AVU triple exists in the collection's
#' metadata, the function returns TRUE; otherwise, it returns FALSE.
#'
#' @export

ri_metaExistsColl <- function(collection, attribute, value, units=NULL) {

    if (!is.character(collection)) 
        stop("ri_metaExistsColl: collection is not character")

    if (!ri_collectionExists(collection))
        stop("ri_metaExistsColl: object does not exists")

    if (!is.character(attribute)) 
        stop("ri_metaExistsColl: attribute is not character")

    if (!is.character(value))
        stop("ri_metaExistsColl: value is not character")

    if (!is.null(units)) {
        if (!is.character(units)) {
            stop("ri_metaExistsColl: units is not character nor NULL")
        }
    }

    res <- avuExists(collection, object = NULL, attribute, value, units)
    return(res)

}
