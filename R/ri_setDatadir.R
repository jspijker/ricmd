#' Set the default data directory
#'
#' This functions sets the default data directory for the user. The
#' directory must exists, otherwise this function generates an error
#'
#' @param datadir path to the default data directory.
#' 
#' @details
#' 
#' Local data files are stored into the iRODS system as data objects.
#' The data directory is the default directory where this package
#' retrieves and stores the files.
#' 
#' @export



ri_setDatadir <- function(datadir) {

    if(!is.character(datadir)) {
        stop("ri_setDatadir: datadir is not character")
    }

    if(!dir.exists(datadir)) {
        stop("ri_setDatadir: datadir does not exist")
    }

    assign("datadir",datadir,envir=.ricmdEnv)

}

