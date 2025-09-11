#'
#' Get THE ranking downloads file id
#' 

the_gdrive_get_download_links <- function(the_id, overwrite = FALSE) {
  the_gdrive_file <- googledrive::drive_ls(path = googledrive::as_id(the_id)) |>
    dplyr::filter(name == "the_overall_ranking")

  file_path <- file.path(tempdir(), "the_overall_rankings.xlsx")

  if (!file.exists(file_path) | overwrite) {
    googledrive::drive_download(
      file = the_gdrive_file, path = file_path, 
      type = "xlsx", overwrite = overwrite
    )
  }
  
  the_download_list <- readxl::read_xlsx(path = file_path)
  the_download_link <- the_download_list$download_link

  names(the_download_link) <- the_download_list$year

  the_download_link
}

