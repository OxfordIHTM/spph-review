#'
#' Get QS 2025 subject ranking criteria
#' 

qs_get_subject_criteria <- function(gdrive_id, year) {
  file_path <- file.path(tempdir(), "qs_criteria.xlsx")

  googledrive::drive_download(
    file = googledrive::as_id(gdrive_id), path = file_path
  )

  qs <- readxl::read_xlsx(path = file_path, sheet = as.character(year))
  
  unlink(file_path)

  qs
}