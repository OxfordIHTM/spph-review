#'
#' Get University of Michigan public health degrees information
#' 

mich_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_title <- current_session |>
    rvest::html_elements(css = "#maincontent h2") |>
    rvest::html_text2() |>
    (\(x) x[c(1:3, 6)])() |>
    gsub(pattern = "\\s\\([A-Z]{2,}\\)", x = _, replacement = "")
  
  degree_name <- current_session |>
    rvest::html_elements(css = "#maincontent ul") |>
    rvest::html_text2() |>
    (\(x) x[c(2, 4)])() |>
    gsub(pattern = "\\s\\(fully online\\)", x = _, replacement = "") |>
    (\(x) c(x, "", ""))() |>
    stringr::str_split(pattern = "\n")

  xlen <- lapply(X = degree_name, FUN = length) |>
    unlist()

  degree_title <- Map(f = rep, x = degree_title, times = xlen) |>
    unlist()

  degree_name <- paste(degree_title, unlist(degree_name), sep = " ") |>
    trimws()

  programme_link <- current_session |>
    rvest::html_elements(css = "#maincontent a") |>
    rvest::html_attr(name = "href") |>
    (\(x) x[c(4:9, 13:16, 19, 30)])()
  
  programme_link[1:12] <- paste0("https://sph.umich.edu", programme_link[1:12])

  tibble::tibble(
    institution = "University of Michigan School of Public Health",
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
} 