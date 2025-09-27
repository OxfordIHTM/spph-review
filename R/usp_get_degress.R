#'
#' Get USP Public Health degree programme information
#' 

usp_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".elementor-size-default") |>
    rvest::html_text2() |>
    (\(x) x[2:7])()
    
   programme_link <- current_session |> 
    rvest::html_elements(css = ".elementor-size-default a") |>
    rvest::html_attr(name = "href") |>
    (\(x) x[1:6])()

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}