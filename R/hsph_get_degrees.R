#'
#' Get links to HSPH masters programmes related to public health
#'

hsph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(
      css = ".program-item .program-item__title-wrapper .program-item__title"
    ) |>
    rvest::html_text2()

  degree_title <- current_session |>
    rvest::html_elements(css = ".program-item__content .wp-block-buttons") |>
    rvest::html_text2() |>
    stringr::str_split(pattern = "\n")

  xlen <- lapply(X = degree_title, FUN = length)

  degree_name <- Map(f = rep, x = degree_name, times = xlen) |>
    unlist()

  degree_title <- unlist(degree_title)

  programme_link <- current_session |>
    rvest::html_elements(css = ".program-item__content .wp-block-buttons a") |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    department = NA_character_,
    degree = paste(degree_title, degree_name, sep = " in "),
    url = programme_link
  ) |>
    dplyr::filter(
      stringr::str_detect(
        string = degree, 
        pattern = "Doctor of Philosophy|Doctor|Dual|Joint", 
        negate = TRUE)
    )
}