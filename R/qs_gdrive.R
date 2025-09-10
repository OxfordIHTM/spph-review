#'
#' Retrieve list of overall QS rankings files in Google Drive
#' 

qs_get_overall_gdrive_list <- function(qs_gdrive_id) {
  googledrive::drive_ls(path = googledrive::as_id(qs_gdrive_id)) |>
    dplyr::filter(name == "overall") |>
    googledrive::drive_ls()
}


#'
#' Download QS rankings data 
#' 

qs_download_overall_rankings <- function(qs_gdrive_file,
                                         destdir,
                                         overwrite = FALSE) {
  if (!dir.exists(destdir)) {
    dir.create(path = destdtir)
  }
  
  download_path <- file.path(destdir, qs_gdrive_file$name)

  if (!file.exists(download_path) | overwrite) {
    googledrive::drive_download(
      file = qs_gdrive_file, path = download_path, overwrite = overwrite 
    )
  }

  download_path
}

