#'
#' Get University of Bristol public health degree information
#' 

brist_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".search-result h1") |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(css = ".search-result a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://www.bristol.ac.uk", x))()

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    dplyr::filter(
      grepl(
        pattern = "Health Sciences Research|Epidemiology|Medical Statistics|Public Health|Population Health Sciences|Translational Health Sciences", 
        x = degree
      )
    )
}