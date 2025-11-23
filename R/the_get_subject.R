#'
#' Get THE subject rankings
#' 

the_get_subject_ranking <- function(gdrive_id) {
  file_path <- file.path(tempdir(), "the_subject_rankings.xlsx")

  googledrive::drive_download(
    file = googledrive::as_id(gdrive_id), path = file_path
  )

  the <- readxl::read_xlsx(file_path)

  unlink(file_path)

  the <- the |>
    dplyr::mutate(
      country = countrycode::countryname(
        sourcevar = the$institution, warn = FALSE
      ) |>
        (\(x) ifelse(is.na(x), the$institution, x))()
    ) |>
    dplyr::mutate(
      rank = stringr::str_remove_all(string = rank, pattern = "\\.0"),
      country = dplyr::case_when(
        grepl(pattern = "Ireland", x = country) ~ "Ireland",
        grepl(pattern = "Germany", x = country) ~ "Germany",
        grepl(pattern = "Saudi Arabia", x = country) ~ "Saudi Arabia",
        grepl(pattern = "United States", x = country) ~ "United States",
        grepl(pattern = "Australia", x = country) ~ "Australia",
        grepl(pattern = "Iran", x = country) ~ "Iran",
        grepl(pattern = "Russian Federation", x = country) ~ "Russian Federation",
        grepl(pattern = "Italy", x = country) ~ "Italy",
        grepl(pattern = "Oman", x = country) ~ "Oman",
        grepl(pattern = "Mexico", x = country) ~ "Mexico",
        grepl(pattern = "Nigeria", x = country) ~ "Nigeria",
        grepl(pattern = "Chile", x = country) ~ "Chile",
        grepl(pattern = "Canada", x = country) ~ "Canada",
        grepl(pattern = "Iraq", x = country) ~ "Iraq",
        .default = country
      ),
      institution = stringr::str_remove_all(
        string = institution, pattern = country
      ) |>
        stringr::str_replace_all(
          pattern = "of $", replacement = paste0("of ", country)
        ) |>
        stringr::str_replace_all(
          pattern = "Hong KongHong Kong", replacement = "Hong Kong"
        ),
      iso3c = countrycode::countrycode(
        sourcevar = country, origin = "country.name.en", destination = "iso3c",
        warn = FALSE
      ),
      un_region = countrycode::countrycode(
        sourcevar = country, origin = "country.name.en", 
        destination = "un.region.name", warn = FALSE
      )
    ) |>
    dplyr::relocate(country:un_region, .after = institution)

  the
}