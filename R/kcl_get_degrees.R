#'
#' Get King's College London public health degree programme information
#' 

kcl_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = "article h3") |>
    rvest::html_text2() |>
    (\(x)
      {
        x <- ifelse(
          grepl(pattern = "MPH", x = x),
          "Master of Public Health",
          x
        )
      
        x <- ifelse(
          grepl(pattern = "MSc", x = x),
          gsub(
            pattern = "\\sMSc|\\sMSc\\s\\(online\\)|\\sMSc\\/PGDip\\/PGCert",
            x = x,
            replacement = ""
          ) |>
            (\(x) paste("Master of Science in", x))(),
          x
        )
      
        x <- ifelse(
          grepl(pattern = "MA", x = x),
          gsub(pattern = "\\sMA", x = x, replacement = "") |>
            (\(x) paste("Master of Arts in", x))(),
          x
        )
      
        x
      }
    )()

  programme_link <- current_session |>
    rvest::html_elements(css = ".wrapper-link") |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    institution = "King's College London",
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    (\(x) x[c(1:3, 6:13, 16, 19:20), ])()
}