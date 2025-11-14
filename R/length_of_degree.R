


plot_length_degree <- function(ph_review_data_released) {
  ph_review_data_released |>
    dplyr::mutate(
      length_months_min = ifelse(
        length_months_min == 2, 24, length_months_min
      )
    ) |>
    dplyr::mutate(
      length_months_min = ifelse(
        department == "Gillings School of Global Public Health", 24,
        length_months_min
      )
    ) |> 
    dplyr::mutate(length_months_min = as.character(length_months_min)) |>
    dplyr::count(length_months_min)
}