#'
#' Get UCL public health degress info 
#' 

ucl_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".accordion__text") |>
    rvest::html_text2() |>
    (\(x) x[10])() |>
    stringr::str_split(pattern = "\n") |>
    unlist() |>
    (\(x)
      {
        ifelse(
          grepl(pattern = "MSc", x = x),
          gsub(pattern = "\\sMSc", x = x, replacement = "") |>
            (\(x) paste("Master of Science in", x))(),
          gsub(pattern = "\\sMPH \\(online\\)", x = x, replacement = "")
        )
      }
    )()
  
  programme_link <- current_session |>
    rvest::html_elements(css = ".accordion__text a") |>
    rvest::html_attr(name = "href") |>
    (\(x) x[38:42])()

  tibble::tibble(
    department = "Institute of Epidemiology and Health Care",
    degree = degree_name,
    url = programme_link
  )
}
