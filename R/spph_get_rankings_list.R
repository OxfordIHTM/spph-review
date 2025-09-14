#'
#' Get rankings list
#' 

spph_get_rankings_list <- function(qs, the, depth = 1, top = 10) {
  qs_year <- qs$year |>
    unique() |>
    sort(decreasing = TRUE) |>
    (\(x) x[1:depth])()

  qs_sub <- qs |>
    dplyr::filter(year %in% qs_year) |>
    dplyr::group_by(year) |>
    dplyr::slice_head(n = top) |>
    dplyr::ungroup() |>
    dplyr::pull(institution) |>
    unique()

  the_year <- the$year |>
    unique() |>
    sort(decreasing = TRUE) |>
    (\(x) x[1:depth])()

  the_sub <- the |>
    dplyr::filter(year %in% the_year) |>
    dplyr::group_by(year) |>
    dplyr::slice_head(n = top) |>
    dplyr::ungroup() |>
    dplyr::pull(institution) |>
    unique()

  c(
    the_sub,
    grepv(
      pattern = paste(the_sub, collapse = "|"),
      x = qs_sub,
      invert = TRUE
    )
  )
}