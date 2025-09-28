#'
#' Get University of Queensland public health degree information
#' 

queen_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".uq-view-grid .grid__col .card .card__header") |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(css = ".uq-view-grid .grid__col .card .card__link") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://study.uq.edu.au", x))()

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    (\(x) x[c(1, 5, 7, 15, 18:20), ])()
}
