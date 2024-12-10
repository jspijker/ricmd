#' Get the name of the data directory
#'
#' @return character string with the name of the data directory
#' @export
#' @examples
#' ri_getDatadir()

ri_getDatadir <- function() {
    # get name of data directory
    if(!testDatadir()) {
        stop("ri_getDatadir: data directory is not set (forgot ri_setDatadir?)")
    }
    res <- get("datadir", envir = .ricmdEnv)
    return(res)
}


