#'
#' Get Oxford University degree programme information
#' 

ox_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  department_name <- current_session |>
    rvest::html_elements(css = ".course-cell .course-department") |>
    rvest::html_text2()

  degree_name <- current_session |>
    rvest::html_elements(css = ".course-cell .course-title") |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(css = ".course-cell .course-title a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://www.ox.ac.uk", x))()

  tibble::tibble(
    department = department_name,
    degree = degree_name,
    url = programme_link
  )
}