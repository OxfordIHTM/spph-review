#'
#' Release RAG database
#' 

release_rag_db <- function(file, name) {
  tag <- paste(
    tools::file_path_sans_ext(name),
    Sys.Date() |> 
      gsub(pattern = "-", replacement = "", x = _),
    sep = "-"
  )

  releases <- piggyback::pb_releases()

  if (ncol(releases) == 0) {
    piggyback::pb_new_release(tag = tag, body = "Database release")
  }
  
  if (!tag %in% releases$release_name) {
    piggyback::pb_new_release(tag = tag, body = "Database release")
  }

  Sys.sleep(time = 60)

  piggyback::pb_upload(file = file, name = name, tag = tag)
}
