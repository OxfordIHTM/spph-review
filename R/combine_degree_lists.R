#'
#' Combine degree lists
#' 

combine_degree_lists <- function(...) {
  rbind(..., deparse.level = 1)
}