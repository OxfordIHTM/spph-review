#'
#' Process degree list for RAG
#' 

process_degree_list <- function(.url, store) {
  ragnar::read_as_markdown(.url) |>
    ragnar::markdown_chunk() |>
    ragnar::ragnar_store_insert(store = store, chunks = _)
}