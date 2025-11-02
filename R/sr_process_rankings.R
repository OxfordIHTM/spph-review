#'
#' Process Shanghai Rankings raw data
#' 

sr_process_ph_rankings <- function(sr_ph_rankings_raw, wb_income_groups) {
  sr_ph_rankings_raw |>
    dplyr::mutate(
      country = countrycode::countrycode(
        sourcevar = country, origin = "country.name.en", 
        destination = "country.name.en"
      ),
      iso3c = countrycode::countrycode(
        sourcevar = country, origin = "country.name.en", destination = "iso3c"
      ),
      un_region = countrycode::countrycode(
        sourcevar = country, origin = "country.name.en", 
        destination = "un.region.name", warn = FALSE
      ),
      wb_region = countrycode::countrycode(
        sourcevar = country, origin = "country.name.en", 
        destination = "region", warn = FALSE
      ),
      overall_score = ifelse(
        is.na(overall_score), 
        faculty + output + research + research_impact + 
          international_collaboration,
        overall_score
      )
    ) |>
    dplyr::left_join(y = wb_income_groups, by = "iso3c") |>
    dplyr::relocate(c(iso3c:wb_region, income_group), .after = country) |>
    dplyr::mutate(
      quintile = dplyr::case_when(
        current_rank %in% c("101-150", "151-200") ~ "Fourth",
        current_rank == "201-300" ~ "Third",
        current_rank == "301-400" ~ "Second",
        current_rank == "401-500" ~ "First",
        .default = "Fifth"
      ) |>
        factor(levels = c("First", "Second", "Third", "Fourth", "Fifth")),
      .before = institution
    ) |>
    dplyr::mutate(
      income_group = factor(
        x = income_group, 
        levels = c(
          "Low income", "Lower middle income", 
          "Upper middle income", "High income"
        )
      )
    )
}