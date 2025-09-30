#'
#' Get HKU public health degree information
#' 

hku_get_master_programme_links <- function(.url) {
  tibble::tibble(
    institution = "Hong Kong University School of Public Health",
    department = NA_character_,
    degree = "Master of Public Health",
    url = .url
  )
}