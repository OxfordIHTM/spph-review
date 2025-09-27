#'
#' Get HKU public health degree information
#' 

hku_get_master_programme_links <- function(.url) {
  tibble::tibble(
    department = NA_character_,
    degree = "Master of Public Health",
    url = .url
  )
}