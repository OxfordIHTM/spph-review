#'
#' Get Imperial School of Public Health degree information
#' 

imp_get_master_programme_links <- function() {
  degree_name <- c(
    "Master of Science in Epidemiology",
    "Master of Public Health",
    "Master of Science in Health Data Analytics and Machine Learning",
    "Master of Research in Epidemiology, Evolution and Control of Infectious Diseases"
  )

  programme_link <- c(
    "https://www.imperial.ac.uk/study/courses/postgraduate-taught/2026/epidemiology/",
    "https://www.imperial.ac.uk/medicine/departments/school-public-health/study/postgraduate/masters/master-of-public-health/",
    "https://www.imperial.ac.uk/study/courses/postgraduate-taught/2026/health-data-analytics/",
    "https://www.imperial.ac.uk/study/courses/postgraduate-taught/2026/epidemiology-evolution-control-infectious-diseases/"
  )

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}