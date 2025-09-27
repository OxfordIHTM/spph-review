#'
#' Erasmus University Rotterdam public health degree information
#' 

eras_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".teaser--linked .teaser__link") |>
    rvest::html_text2() |>
    (\(x) ifelse(grepl(pattern = "European", x = x), x, paste("Master in", x)))()

  programme_link <- current_session |>
    rvest::html_elements(css = ".teaser--linked .teaser__link") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://www.eur.nl", x))()

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}
