#'
#' Upload RAG duckdb to Google Drive
#' 

db_gdrive_upload <- function(db, name, gdrive_id, overwrite = FALSE) {
  file_list <- googledrive::drive_ls(path = googledrive::as_id(gdrive_id))

  if (nrow(file_list) == 0) {
    googledrive::drive_upload(
      media = db, path = googledrive::as_id(gdrive_id),
      name = name, overwrite = overwrite
    )
  } else {
    if (!grepl(pattern = name, x = file_list$name) | overwrite) {
      googledrive::drive_upload(
        media = db, path = googledrive::as_id(gdrive_id),
        name = name, overwrite = overwrite
      )
    } 
  }

  googledrive::drive_ls(path = googledrive::as_id(gdrive_id)) |>
    dplyr::filter(name == name)
}