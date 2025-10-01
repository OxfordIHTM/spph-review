#'
#' Get Karolinska Institutet degree programme information
#' 

karol_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".contextual-region .col_0 a") |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(css = ".contextual-region .col_0 a") |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    institution = "Karolinska Institutet",
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}