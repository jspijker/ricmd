#' Set the default data directory
#'
#' This functions sets the default data directory for the user. The
#' directory will be created when it does not exist. 
#'
#' @param datadir path to the default data directory, if empty it
#' it uses a directory 'data' in the current working directory.
#' @param ... additional arguments to datafile::datafileInit
#' 
#' Local data files are stored into the iRODS system as data objects.
#' The data directory is the default directory where this package
#' retrieves and stores the files. To manage this directory the
#' `datafile` package is used
#' 
#'  Using a seperate data directory makes it easier to seperate data
#'  and code. See the vignette of the `datafile` package for more
#'  information.
#' 
#' @export



ri_setDatadir <- function(datadir) {

    if(!is.character(datadir)) {
        stop("ri_setDatadir: datadir is not character")
    }

    if(!dir.exists(datadir)) {
        stop("ri_setDatadir: datadir does not exist")
    }

    assign("datadir",datadir,env=.ricmdEnv)

}

