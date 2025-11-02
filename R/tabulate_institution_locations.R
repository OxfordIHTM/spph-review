#'
#' Tabulate institution locations
#' 

tabulate_institution_locations <- function(ph_review_data_released,
                                           area = c("country", "region")) {
  area <- match.arg(area)
  
  if (area == "country") {
    ph_review_data_released |>
      dplyr::count(country) |>
      dplyr::mutate(
        perc = (n / sum(n)) |>
          scales::label_percent(accuracy = NULL)()
      ) |>
      dplyr::arrange(dplyr::desc(n))
  } else {
    ph_review_data_released |>
      dplyr::count(un_region) |>
      dplyr::mutate(
        perc = (n / sum(n)) |>
          scales::label_percent(accuracy = NULL)()
      ) |>
      dplyr::arrange(dplyr::desc(n))
  }
}