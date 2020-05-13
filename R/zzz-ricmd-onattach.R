#' @import reticulate

.onAttach <- function(...) {

    cat("loading ricmd python3 environment\n\n")

    pybinary <- Sys.which("python3")
    reticulate::use_python(pybinary,required=TRUE)
    print(reticulate::py_config())

    assign("onAttach_success",reticulate::py_available(),envir=.ricmdEnv)


}
