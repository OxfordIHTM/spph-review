#'
#' Get JHU BSPH programme information
#' 

bsph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".content-component__title") |>
    rvest::html_text2() |>
    gsub(pattern = "\\s\\([A-Z]{2,}\\)", x = _, replacement = "")

  fixed <- current_session |>
    rvest::html_elements(css = ".content-component__links") |>
    rvest::html_text2() |>
    grepl(pattern = "Learn|learn", x = _)

  programme_link <- current_session |>
    rvest::html_elements(css = ".content-component__links a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://publichealth.jhu.edu", x))() 
  
  rbind(
    tibble::tibble(
      department = NA_character_,
      degree = degree_name,
      url = programme_link
    ),
    programme_link[!fixed] |>
      lapply(FUN = bsph_get_sub_master_programme_links) |>
      dplyr::bind_rows()
  )
}


bsph_get_sub_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  department_name <- current_session |>
    rvest::html_elements(css = ".field-department") |>
    rvest::html_text2() |>
    gsub(pattern = "Offered by: ", x = _, replacement = "")

  degree_name <- current_session |>
    rvest::html_elements(css = ".teaser-title") |>
    rvest::html_text2() |>
    gsub(
      pattern = "\\s\\([A-Z]{2,}\\)|\\s\\([A-Z]{2,}\\/[A-Z]{2,}\\)|\\s\\(ScM\\)", 
      x = _, replacement = ""
    )
  
  department_name <- ifelse(
    length(department_name) < length(degree_name),
    c(
      department_name[1:6], NA_character_, 
      department_name[7:length(department_name)]
    ),
    department_name
  )
  
  programme_link <- current_session |>
    rvest::html_elements(css = ".teaser-title a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://publichealth.jhu.edu", x))()
  
  tibble::tibble(
    department = department_name,
    degree = degree_name,
    url = programme_link
  )
}

