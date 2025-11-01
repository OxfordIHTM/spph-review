#'
#' Get Yale public health degrees information
#' 

ysph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(
      css = ".summary-list-item__link"
    ) |>
    rvest::html_text2() |>
    (\(x) 
      {
        x <- ifelse(
          grepl(pattern = "Executive", x = x),
          "Executive Master of Public Health",
          x
        )
        
        x <- ifelse(
          grepl(pattern = "Advanced", x = x),
          "Advanced Professional Master of Public Health",
          x
        )
      
        x <- ifelse(
          grepl(pattern = "(MPH)", x = x),
          "Master of Public Health",
          x
        )
      
        x <- ifelse(
          grepl(pattern = "Master of Science in Public Health", x = x),
          "Master of Science in Public Health",
          x
        )
      
        x
    }
    )()

  programme_link <- current_session |>
    rvest::html_elements(
      css = ".summary-list-item__link"
    ) |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://ysph.yale.edu", x))()

  tibble::tibble(
    institution = "Yale School of Public Health",
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    (\(x) x[c(1:3, 5), ])()
}