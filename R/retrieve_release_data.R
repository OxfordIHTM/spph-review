#'
#' Retrieve review data from GitHub
#' 

spph_get_review_data <- function(file, 
                                 release = "latest", 
                                 dirpath = ".", 
                                 overwrite = FALSE) {
  if (!dir.exists(dirpath)) {
    dir.create(path = dirpath, showWarnings = FALSE)
  }
  
  ## Check if db_name is already present in dirpath
  file_path <- file.path(dirpath, file)

  if (!file.exists(file_path) | overwrite) {
    piggyback::pb_download(
      file = file,
      dest = dirpath,
      tag = release,
      overwrite = overwrite
    )
  }

  file_path
}