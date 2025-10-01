#'
#' Get University of British Columbia degree programme information
#' 

ubc_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(
      css = ".wp-block-column-is-layout-flow .c-accordion__title.js-accordion-controller"
    ) |>
    rvest::html_text2() |>
    (\(x) x[c(2:6, 10:12)])()

  programme_link <- current_session |>
    rvest::html_elements(
      css = ".wp-block-column-is-layout-flow .is-open p a"
    ) |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    institution = "University of British Columbia School of Population and Public Health",
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    dplyr::filter(!grepl(pattern = "Doctor", x = degree))
}