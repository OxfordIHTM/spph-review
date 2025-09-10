
#'
#' 
#' 


qs_download_rankings <- function(.url, 
                                 destdir = "data-raw/qs_rankings",
                                 overwrite = FALSE) {
  ## See if file already exists ----
  file_path <- file.path(destdir, "qs_world_rankings_2026.xlsx")

  if (!file.exists(file_path)) {
    download.file(url = .url, destfile = file_path, mode = "wb")
  } else {
    if (overwrite) {
      download.file(url = .url, destfile = file_path, mode = "wb")
    }
  }

  file_path
}


#'
#' 
#' 

qs_download_subject_rankings <- function(.url, 
                                         destdir = "data-raw/qs_rankings",
                                         overwrite = FALSE) {
  ## See if file already exists ----
  file_path <- file.path(destdir, "qs_world_rankings_2026.xlsx")

  if (!file.exists(file_path)) {
    download.file(url = .url, destfile = file_path, mode = "wb")
  } else {
    if (overwrite) {
      download.file(url = .url, destfile = file_path, mode = "wb")
    }
  }

  file_path
}