#'
#' Get JHU BSPH programme information
#' 

bsph_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  fixed <- current_session |>
    rvest::html_elements(css = ".content-component__links") |>
    rvest::html_text2() |>
    grepl(pattern = "Learn more|learn more", x = _)

  degree_name <- current_session |>
    rvest::html_elements(css = ".content-component__title") |>
    rvest::html_text2() |>
    gsub(pattern = "\\s\\([A-Z]{2,}\\)", x = _, replacement = "") |>
    (\(x) x[fixed])()

  programme_links <- current_session |>
    rvest::html_elements(css = ".content-component__links a") |>
    rvest::html_attr(name = "href")

  programme_link <- programme_links[fixed] |>
    (\(x) paste0("https://publichealth.jhu.edu", x))()
  
  set1 <- tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )

  not_fixed_links <- programme_links[!fixed] |>
    (\(x) paste0("https://publichealth.jhu.edu", x))()

  set2_session <- not_fixed_links[1] |>
    rvest::session()

  set2_department <- set2_session |>
    rvest::html_elements(css = ".field-department span") |>
    rvest::html_text2() |>
    gsub(pattern = "Offered by: ", x = _, replacement = "")

  set2_degree_name <- set2_session |>
    rvest::html_elements(css = ".views-row .teaser h3") |>
    rvest::html_text2()

  set2_programme_link <- set2_session |>
    rvest::html_elements(css = ".views-row .teaser-title a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://publichealth.jhu.edu", x))()

  set2 <- tibble::tibble(
    department = set2_department,
    degree = set2_degree_name,
    url = set2_programme_link
  )

  set3_session <- not_fixed_links[2] |>
    rvest::session()

  set3_degree_name <- set3_session |>
    rvest::html_elements(css = ".fiftyfifty-contained__columns h2") |>
    rvest::html_text2()

  set3_programme_link <- set3_session |>
    rvest::html_elements(css = ".fiftyfifty-contained__columns a") |>
    rvest::html_attr(name = "href") |>
    (\(x) x[c(1, 3:7)])() |>
    (\(x) paste0("https://publichealth.jhu.edu", x))()

  set3 <- tibble::tibble(
    department = NA_character_,
    degree = set3_degree_name,
    url = set3_programme_link
  ) |>
    (\(x) x[1:3, ])()

  set4_session <- not_fixed_links[3] |>
    rvest::session()

  set4_department <- set4_session |>
    rvest::html_elements(css = ".views-row .field-department") |>
    rvest::html_text2() |>
    gsub(pattern = "Offered by: ", x = _, replacement = "") |>
    (\(x) c(x[1:6], NA_character_, x[7:10]))()

  set4_degree_name <- set4_session |>
    rvest::html_elements(css = ".views-row .teaser-title") |>
    rvest::html_text2()

  set4_programme_link <- set4_session |>
    rvest::html_elements(css = ".views-row .teaser-title a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://publichealth.jhu.edu", x))()

  set4 <- tibble::tibble(
    department = set4_department,
    degree = set4_degree_name,
    url  = set4_programme_link
  )

  set5_session <- not_fixed_links[4] |>
    rvest::session()

  set5_department <- set5_session |>
    rvest::html_elements(css = ".views-row .field-department") |>
    rvest::html_text2() |>
    gsub(pattern = "Offered by: ", x = _, replacement = "")

  set5_degree_name <- set5_session |>
    rvest::html_elements(css = ".views-row .teaser-title") |>
    rvest::html_text2()

  set5_programme_link <- set5_session |>
    rvest::html_elements(css = ".views-row .teaser-title a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://publichealth.jhu.edu", x))()

  set5 <- tibble::tibble(
    department = set5_department,
    degree = set5_degree_name,
    url  = set5_programme_link
  )

  rbind(set1, set2, set3, set4, set5)
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

