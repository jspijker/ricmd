#' Add a metadata attribute-value-unit (AVU) triplet to a collection
#' in iRODS.
#'
#' This function adds a metadata attribute-value-unit (AVU) triplet to a collection
#' in iRODS. The AVU triplet consists of an attribute name, a value,
#' and an optional unit.
#'
#' @param collection The name of the collection to which the metadata
#' will be added.
#' @param attribute The name of the metadata attribute to be added.
#' @param value The value of the metadata attribute to be added.
#' @param units An optional unit for the metadata attribute. If not provided, it defaults to NULL.
#'
#' @return This function does not return any value. It adds the specified
#' metadata to the specified collection in iRODS.
#' @details
#' The function checks if the provided collection, attribute, and value
#' are character strings. If the units parameter is provided, it also checks
#' if it is a character string. If any of these checks fail, an error is
#' raised. Additionally, the function checks if the specified collection
#' exists in iRODS. If the collection does not exist, an error is raised.
#'
#'@export

ri_metaAddColl <- function(collection, attribute, value, units=NULL) {


    if (!is.character(collection)) {
        stop("ri_metaAddColl: collection is not character")
    }

    if (!is.character(attribute)) {
        stop("ri_metaAddColl: attribute is not character")
    }

    if (!is.character(value)) {
        stop("ri_metaAddColl: value is not character")
    }

    if (!is.null(units)) {
        if (!is.character(units)) {
            stop("ri_metaAddColl: units is not character nor NULL")
        }
    }

    if (!ri_collectionExists(collection)) {
        stop("ri_metaAddColl: collection does not exists")
    }

    avuStore(collection, object = NULL, attribute, value, units)
}
