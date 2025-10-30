#'
#' Process review data
#' 

process_review_data <- function(ph_review_data,
                                sr_public_health_rankings,
                                ph_modules_core_category,
                                ph_modules_option_category) {
  df <- add_module_core_categories(
    ph_review_data = ph_review_data, 
    ph_modules_category = ph_modules_core_category,
    collapse = TRUE
  )

  df <- add_module_options_categories(
    ph_review_data = df,
    ph_modules_option_category = ph_modules_option_category,
    collapse = TRUE
  )

  df <- sr_public_health_rankings |>
    dplyr::slice(1:30) |>
    dplyr::select(
      institution, country, iso3c, un_region, wb_region, income_group
    ) |>
    dplyr::right_join(
      y = df, by = "institution"
    )

  df
}