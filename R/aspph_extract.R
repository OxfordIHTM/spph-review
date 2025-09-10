#'
#' Extract information on ASPPH member institutions from website
#' 

aspph_extract_members_list <- function(.url) {
  url_session <- rvest::session(.url)

  institution <- rvest::html_elements(
    x = url_session, css = ".pt-4 .memdir-inst-name"
  ) |>
    rvest::html_text()

  accreditation_status <- rvest::html_elements(
    x = url_session, css = ".pt-4 .fw-bold"
  ) |>
    rvest::html_text() |>
    matrix(nrow = length(institution), ncol = 3, byrow = TRUE) |>
    data.frame() |>
    setNames(
      nm = c(
        "ceph_accreditation_status", 
        "membership_start", 
        "primary_representative"
      )
    )
  
  institution_link <- rvest::html_elements(
    x = url_session, css = ".pt-4 a"
  ) |>
    rvest::html_attr(name = "href") |>
    (\(x) x[grep(pattern = "collapse|programfinder", x = x, invert = TRUE)])()
  
  tibble::tibble(
    institution,
    accreditation_status,
    institution_link
  )
}