
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
