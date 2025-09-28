#'
#' Get Yale public health degrees information
#' 

ysph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(
      css = ".base-page .content .component-wrapper .summary-list-item h2"
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
          grepl(pattern = "Degree", x = x),
          "Master of Public Health",
          x
        )  
      
        x
      }
    )()

  programme_link <- current_session |>
    rvest::html_elements(
      css = ".base-page .content .component-wrapper .summary-list-item a"
    ) |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://ysph.yale.edu", x))()

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    (\(x) x[c(1:3, 5), ])()
}