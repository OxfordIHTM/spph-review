#'
#' Get Gillings School of Public Health degree information
#' 

gsph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  mph_degree_name <- current_session |>
    rvest::html_elements(css = ".altblocks_content h3") |>
    rvest::html_text2() |>
    (\(x) x[1:3])() |>
    gsub(pattern = "\\s\\([A-Z]{2,}\\)", x = _, replacement = "") |>
    (\(x) c(x, x[3]))()

  links <- current_session |>
    rvest::html_elements(css = ".altblocks_content-wrapper .w-button") |>
    rvest::html_attr(name = "href")

  mph_programme_link <- links |>
    (\(x) x[1:4])()

  mph <- tibble::tibble(
    department = NA_character_,
    degree = mph_degree_name,
    url = mph_programme_link
  )

  sub_session <- rvest::session(url = links[5])

  degree_generic <- sub_session |>
    rvest::html_elements(css = ".altblocks_content-wrapper h3") |>
    rvest::html_text2() |>
    gsub(pattern = "\\s\\([A-Z]{2,}\\)", x = _, replacement = "") |>
    (\(x) c(x[1], paste(rep(x[2], 3), "in"), x[3:5]))()
  
  degree_specific <- sub_session |>
    rvest::html_elements(css = ".altblocks_content-wrapper .w-button") |>
    rvest::html_text2() |>
    gsub(
      pattern = "\\\nProgram and Application Details|Program and Application Details|Program Details",
      x = _, replacement = ""
    )
  
  degree_name <- paste(degree_generic, degree_specific) |>
    trimws()

  programme_link <- sub_session |>
    rvest::html_elements(css = ".altblocks_content-wrapper .w-button") |>
    rvest::html_attr(name = "href")

  rbind(
    mph,
    tibble::tibble(
      department = NA_character_,
      degree = degree_name,
      url = programme_link
    )
  )
}
