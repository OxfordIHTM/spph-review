#'
#' Get Mailman School of Public Health degree programmes information
#' 

mail_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".cb-content-area__feature-rows h3") |>
    rvest::html_text2()
  
  programme_link <- current_session |>
    rvest::html_elements(css = ".cb-content-area__feature-rows h3 a") |>
    rvest::html_attr(nam = "href") |>
    (\(x) paste0("https://www.publichealth.columbia.edu", x))()

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}