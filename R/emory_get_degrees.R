#'
#' Get Rollins School of Public Health degree information
#' 

emory_get_master_programme_links <- function(base_url, page) {
  .url <- paste0(base_url, "&page=", page)

  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".coh-ce-a8a358aa .coh-interaction") |>
    rvest::html_text2() |>
    gsub(pattern = "12-Month ", x = _, replacement = "") |>
    gsub(pattern = "MPH", x = _, replacement = "Master of Public Health") |>
    gsub(
      pattern = "MSPH", x = _, 
      replacement = "Master of Science in Public Health"
    )
  
  programme_link <- current_session |>
    rvest::html_elements(css = ".coh-ce-763d4d13") |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}