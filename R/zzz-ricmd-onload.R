#' @import reticulate

.onLoad <- function(...) {

    packageStartupMessage("loading ricmd python3 environment\nuse 'reticulate::py_config()' to see information about your python environment")

    pybinary <- Sys.which("python3")
    reticulate::use_python(pybinary,required=TRUE)
    reticulate::py_config()
    assign("onAttach_success", reticulate::py_available(), envir = .ricmdEnv)
}
