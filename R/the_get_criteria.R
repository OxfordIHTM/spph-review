#'
#' Get THE 2025 subject ranking criteria
#' 

the_get_subject_criteria <- function(gdrive_id, year) {
  file_path <- file.path(tempdir(), "the_criteria.xlsx")

  googledrive::drive_download(
    file = googledrive::as_id(gdrive_id), path = file_path
  )

  the <- readxl::read_xlsx(path = file_path, sheet = as.character(year))
  
  unlink(file_path)

  the
}