#'
#' Get THE subject rankings
#' 

qs_get_subject_ranking <- function(gdrive_id) {
  file_path <- file.path(tempdir(), "qs_subject_rankings.xlsx")

  googledrive::drive_download(
    file = googledrive::as_id(gdrive_id), path = file_path
  )

  qs <- readxl::read_xlsx(
    file_path, sheet = "Life Sciences & Medicine", skip = 10
  ) |>
    dplyr::mutate(
      iso3c = countrycode::countrycode(
        sourcevar = `Country / Territory`, origin = "country.name.en", 
        destination = "iso3c", warn = FALSE
      ),
      un_region = countrycode::countrycode(
        sourcevar = `Country / Territory`, origin = "country.name.en",
        destination = "un.region.name", warn = FALSE
      ),
      .after = `Country / Territory`
    )

  unlink(file_path)

  qs
}