#'
#' Get Dalla Lana School of Public Health programme information
#' 

dlsph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".program-list .colof-1 h4") |>
    rvest::html_text2() |>
    (\(x)
      {
        x <- ifelse(
          grepl(pattern = "MPH", x = x),
          gsub(pattern = "MPH: ", x = x, replacement = "") |>
            (\(x) paste("Master of Public Health in", x))(),
          x
        )
      
        x <- ifelse(
          grepl(pattern = "MScCH", x = x),
          gsub(pattern = "MScCH: ", x = x, replacement = "") |>
            (\(x) paste("Master of Science in Community Health:", x))(),
          x
        ) 

        x <- ifelse(
          grepl(pattern = "MSc", x = x),
          gsub(pattern = "MSc: ", x = x, replacement = "") |>
            (\(x) paste("Master of Science in", x))(),
          x
        )

        x <- ifelse(
          grepl(pattern = "MHSc", x = x),
          gsub(pattern = "MHSc: ", x = x, replacement = "") |>
            (\(x) paste("Master of Health Science in", x))(),
          x
        )
        
        x
      }
    )()

  programme_link <- current_session |>
    rvest::html_elements(css = ".program-list .colof-1 a") |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}