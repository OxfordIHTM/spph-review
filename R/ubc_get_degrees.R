#'
#' Get University of British Columbia degree programme information
#' 

ubc_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  current_session |>
    rvest::html_elements(
      css = ".wp-block-column-is-layout-flow .c-accordion__title.js-accordion-controller"
    ) |>
    rvest::html_text2()
}