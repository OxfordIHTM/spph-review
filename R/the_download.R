#'
#' Download THE rankings digital edition files 
#'

the_download_ranking_file <- function(.url, destdir, overwrite = FALSE) {
  file_path <- file.path(
    destdir, 
    paste0("the_rankings_", names(.url), ".pdf")
  )

  if (!file.exists(file_path) | overwrite) {
    withr::with_options(
      list(timeout = 300),
      download.file(url = .url, destfile = file_path, mode = "wb")
    )
  }

  file_path
}