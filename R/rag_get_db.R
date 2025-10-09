#'
#' Retrieve RAG database from GitHub release
#' 

spph_get_database <- function(db_name, release = "latest", 
                             dirpath = ".", overwrite = FALSE) {
  if (!dir.exists(dirpath)) {
    dir.create(path = dirpath, showWarnings = FALSE)
  }
  
  ## Check if db_name is already present in dirpath
  file_path <- file.path(dirpath, db_name)

  if (!file.exists(file_path) | overwrite) {
    piggyback::pb_download(
      file = db_name,
      dest = dirpath,
      tag = release,
      overwrite = overwrite
    )
  }

  file_path
}
