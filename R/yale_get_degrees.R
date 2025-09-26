#'
#' Get Yale public health degrees information
#' 

yale_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(
      css = ".base-page .content .component-wrapper .summary-list-item h2"
    ) |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(
      css = ".base-page .content .component-wrapper .summary-list-item a"
    ) |>
    rvest::html_attr(name = "href") |>
    (\(x) file.path("https://ysph.yale.edu", x))()

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}