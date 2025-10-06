#'
#' Get UPenn Perelman School of Medicine public health degrees information
#' 

upen_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".grid h4") |>
    rvest::html_text2() |>
    gsub(pattern = "\\s\\([A-Z]{2,}\\)", x = _, replacement = "") |>
    (\(x) x[c(1:9, 11:14)])()

  programme_link <- current_session |>
    rvest::html_elements(css = ".grid a") |>
    rvest::html_attr(name = "href") |>
    grepv(pattern = "https", x = _) |>
    (\(x) x[c(1, 3, 5:6, 8, 10, 12:13, 15, 18, 21, 23, 25)])()

  programme_link[2] <- "https://catalog.upenn.edu/graduate/programs/biomedical-informatics-mbmi/"

  tibble::tibble(
    institution = "University of Pennsylvania",
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}

