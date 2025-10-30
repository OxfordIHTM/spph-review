#'
#' Expand module variable
#' 

expand_module <- function(ph_review_data, 
                          type = c("core", "option", "track")) {
  type <- match.arg(type)

  if (type == "core") {
    df <- ph_review_data |>
      dplyr::mutate(
        modules_core = stringr::str_split(string = modules_core, pattern = "; ")
      ) |>
      tidyr::unnest(cols = modules_core)
  }

  if (type == "option") {
    df <- ph_review_data |>
      dplyr::mutate(
        modules_option = stringr::str_split(
          string = modules_option, pattern = "; "
        )
      ) |>
      tidyr::unnest(cols = modules_option)
  }

  if (type == "track") {
    df <- ph_review_data |>
      dplyr::mutate(
        tracks_specialisation = stringr::str_split(
          string = tracks_specialisation, pattern = "; "
        )
      ) |>
      tidyr::unnest(cols = tracks_specialisation)
  }

  df
}