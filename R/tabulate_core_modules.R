#'
#' Tabulate core modules
#' 

tabulate_categories <- function(module_category, module) {
  df <- expand_categories(module_category, module)

  col_sums <- df |>
    colSums()

  data.frame(
    core_module = names(col_sums),
    n = unname(col_sums)
  ) |>
    dplyr::mutate(
      perc = (n / 30) |>
        scales::label_percent(accuracy = NULL)()
    ) |>
    dplyr::arrange(dplyr::desc(n)) |>
    tibble::as_tibble()
}