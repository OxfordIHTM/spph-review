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
        faculty + output + research + research_impact + international_collaboration,
        overall_score
      ),
      url_shanghai_ranking = file.path(
        "https://www.shanghairanking.com/institution",
        institution |>
          stringr::str_remove_all(pattern = "\\(|\\)|\\s-|\\'|\\,") |>
          tolower() |>
          gsub(pattern = "\\s", replacement = "-", x = _)
      )
    ) |>
    dplyr::left_join(y = wb_income_groups, by = "iso3c") |>
    dplyr::relocate(c(iso3c:wb_region, income_group), .after = country)
}