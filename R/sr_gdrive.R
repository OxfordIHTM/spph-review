#'
#' 
#' 

sr_get_gdrive_list <- function(gdrive_id) {
  googledrive::drive_ls(path = googledrive::as_id(gdrive_id)) |>
    dplyr::filter(name == "shanghai_rankings_public_health")
}


#'
#' Download Shanghai Rankings data 
#' 

sr_download_ph_rankings <- function(sr_gdrive_file, 
                                    destdir,
                                    overwrite = FALSE) {
  if (!dir.exists(destdir)) {
    dir.create(destdir)
  }
  
  download_path <- file.path(destdir, "sr_ph_rankings.xlsx")

  if (!file.exists(download_path) | overwrite) {
    googledrive::drive_download(
      file = sr_gdrive_file, path = download_path, 
      type = "xlsx", overwrite = overwrite 
    )
  }

  download_path
}