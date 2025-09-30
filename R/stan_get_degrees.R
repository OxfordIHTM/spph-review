#'
#' Get Stanford University public health degree programmes 
#' 

stan_get_master_programme_links <- function() {
  tibble::tribble(
    ~institution, ~department, ~degree, ~url,
    "Stanford University",
    "Department of Epidemiology and Population Health",
    "Master's of Science in Epidemiology and Clinical Research",
    "https://med.stanford.edu/epidemiology-dept/education/MS-overview2.html"
  )
}