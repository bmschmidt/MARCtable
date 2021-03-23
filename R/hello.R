

#' Install pymarc
#'
#' @param method passed to reticulate::py_install
#' @param conda passed to reticulate::py_install for pyarrow.
#'
#' @return
#' @export
#'
install_pymarc <- function(method = "auto", conda = "auto") {
  reticulate::py_install("pyarrow", method = method, conda = conda)
  reticulate::py_install("pymarc", method = method, pip = TRUE)
}


#' Read a MARC file as a table
#'
#' @param path Location of a MARC21 file.
#' @param fields Fields to read. If full fields (e.g., "650", all subfields will be turned into a nested dataframe).
#'               If you want only a subfield, separate with dollar signs: e.g., '650$a'. You may also use a few special
#'               pymarc labels like "author", "title", etc.
#' @param format If this is tibble, object will be coerced to a tibble. Otherwise, it will be an arrow frame.
#' @param n_max Maximum number of records to read.
#'
#' @return
#' @export
#'
#' @examples


read_MARC <- function(path, fields, format = "tibble", n_max) {
  f <- function(path, fields, format = "tibble", n_max) {
    if (is.null(MARC)) {stop("Unable to load MARC")}
    p = MARC$parse_file(path, fields, n_max)
    if (format == "tibble") {return(tibble::as_tibble(p))}
    return(p)
  }
  return(f)
}


.onLoad <- function(libname, pkgname) {
  # use superassignment to update global reference to scipy
  path = system.file(".", package="MARCtable")
  reticulate::use_condaenv("r-reticulate")
  MARC <<- reticulate::import_from_path("src", path, delay_load = FALSE)

}


