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

  piggyback::pb_release_create(tag = tag, body = "Database release")

  piggyback::pb_upload(file = file, name = name)

  name
}