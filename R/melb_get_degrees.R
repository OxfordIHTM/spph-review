#'
#' Get University of Melbourne public health degree information
#' 

melb_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".section li") |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(css = ".section li a") |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    (\(x) x[c(1, 4:6), ])()
}