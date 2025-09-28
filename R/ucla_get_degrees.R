#'
#' Get links to UCLA masters programmes related to public health
#' 

ucla_get_master_programme_links <- function(base_url, page) {
  .url <- paste0(base_url, "&page=", page)

  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(
      css = ".program-card__content .program-card__heading"
    ) |>
    rvest::html_text2()

  department_name <- current_session |>
    rvest::html_elements(css = ".program-card__labels") |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(css = ".program-card__options .program-card__link a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://ph.ucla.edu", x))()

  tibble::tibble(
    department = department_name,
    degree = degree_name,
    url = programme_link
  )
}