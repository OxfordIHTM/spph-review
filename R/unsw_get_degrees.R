#'
#' Get UNSW public health degree information
#' 

unsw_get_master_programme_links <- function() {
  tibble::tribble(
    ~department, ~degree, ~url,
    NA_character_,
    "Master of Public Health",
    "https://www.unsw.edu.au/study/postgraduate/master-of-public-health"
  )
}