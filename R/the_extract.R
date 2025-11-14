#'
#' Extract medicine and health rankings
#' 

.url <- "https://www.timeshighereducation.com/world-university-rankings/2025/subject-ranking/clinical-pre-clinical-health#!/length/-1/sort_by/rank/sort_order/asc/cols/scores"

the_extract_health <- function(.url) {
  current_session <- rvest::session(.url)

  current_session |>
    rvest::html_elements(css = ".content-primary #datatable-1") |>
    rvest::html_table()
}