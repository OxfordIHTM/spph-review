#'
#' Get University of Ottawa Public Health degree programme information
#' 

uott_get_master_programme_links <- function() {
  tibble::tibble(
    institution = "University of Ottawa School of Epidemiology and Public Health",
    department = NA_character_,
    degree = "Master of Public Health",
    url = "https://www.uottawa.ca/faculty-medicine/graduate-postdoctoral/programs-admission/program-information/MPH"
  )
}