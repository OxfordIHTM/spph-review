#'
#' Get University of Sydney SPH degree programme information
#' 

sydn_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".cmp-accordion__panel-inner ul li") |>
    rvest::html_text2() |>
    (\(x) x[57:65])()

  programme_link <- current_session |>
    rvest::html_elements(css = ".cmp-accordion__panel-inner li a") |>
    rvest::html_attr(name = "href") |>
    (\(x) x[59:67])() |>
    (\(x) paste0("https://www.sydney.edu.au", x))()

  tibble::tibble(
    institution = "University of Sydney School of Public Health",
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    dplyr::filter(!grepl(pattern = "Diploma", x = degree))
}