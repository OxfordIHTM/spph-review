#'
#' Get Mailman School of Public Health degree programmes information
#' 

mail_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  degree_name <- current_session |>
    rvest::html_elements(css = ".cb-content-area__feature-rows h3") |>
    rvest::html_text2()
  
  programme_link <- current_session |>
    rvest::html_elements(css = ".cb-content-area__feature-rows h3 a") |>
    rvest::html_attr(nam = "href") |>
    (\(x) paste0("https://www.publichealth.columbia.edu", x))()

  set1 <- tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  ) |>
    (\(x) x[c(1, 3), ])()

  sub_session <- programme_link[2] |>
    rvest::session()

  sub_department <- c(
    rep("Department of Biostatistics", 6),
    rep("Department of Environmental Health Sciences", 2),
    rep("Department of Epidemiology", 2),
    "Department of Population and Family Health",
    "Department of Sociomedical Sciences"
  )

  sub_degree <- sub_session |>
    rvest::html_elements(css = ".field-label-hidden a") |>
    rvest::html_text2() |>
    (\(x) x[c(9:14, 16:17, 19:20, 22, 4)])()

  sub_link <- sub_session |>
    rvest::html_elements(css = ".field-label-hidden a") |>
    rvest::html_attr(name = "href") |>
    (\(x) x[c(9:14, 16:17, 19:20, 22, 24)])() |>
    (\(x) paste0("https://www.publichealth.columbia.edu", x))()

  set2 <- tibble::tibble(
    department = sub_department,
    degree = sub_degree,
    url = sub_link
  )

  rbind(set1, set2)
}