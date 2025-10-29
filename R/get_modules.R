#'
#' Get vector of modules
#' 

get_modules <- function(ph_review_data) {
  ph_review_data$modules_core |>
    paste(collapse = "; ")
}