#'
#' Get University of Washington School of Public Health degree information
#' 

wsph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".card-block li") |>
    rvest::html_text2() |>
    gsub(pattern = "MS", x = _, replacement = "Master of Science") |>
    gsub(pattern = "MPH", x = _, replacement = "Master of Public Health")

  programme_link <- current_session |>
    rvest::html_elements(css = ".card-block li a") |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    dplyr::filter(grepl(pattern = "Master", x = degree))
}