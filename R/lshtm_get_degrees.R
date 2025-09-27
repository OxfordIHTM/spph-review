#'
#' Get LSHTM public health degrees information
#' 

lshtm_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(
    url = .url, 
    httr::user_agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36")
  )

  current_session |>
    rvest::html_elements(
      css = ".content .filter-table"
    ) |>
    rvest::html_table()
}