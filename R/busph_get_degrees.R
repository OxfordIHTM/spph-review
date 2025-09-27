#'
#' Get BUSPH degree programme information
#' 

busph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".bu-list-child-pages .child-page-content h3") |>
    rvest::html_text2() |>
    gsub(
      pattern = "\\s\\([A-Z]{2,}\\)|\\s\\(PhD\\)|\\s\\(DrPH\\)",
      x = _, replacement = ""
    )

  programme_link <- current_session |>
    rvest::html_elements(
      css = ".bu-list-child-pages .child-page-content h3 a"
    ) |>
    rvest::html_attr(name = "href")

  mph <- tibble::tibble(
    department = NA_character_,
    degree = degree_name[1],
    url = programme_link[1]
  )

  sub_session <- rvest::session(url = programme_link[3])

  degree_name <- sub_session |>
    rvest::html_elements(css = ".hentry h3") |>
    rvest::html_text2() |>
    (\(x) x[1:3])() |>
    gsub(pattern = "MS", x = _, replacement = "Master of Science")

  programme_link <- sub_session |>
    rvest::html_elements(css = ".hentry .btn-arrow") |>
    rvest::html_attr(name = "href") |>
    (\(x) x[1:3])()

  rbind(
    mph,
    tibble::tibble(
      department = NA_character_,
      degree = degree_name,
      url = programme_link
    )
  )
}