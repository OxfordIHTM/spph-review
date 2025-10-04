#'
#' Process degree for RAG
#' 

process_degree <- function(.url, store) {
  if (!httr::http_error(.url)) {
    x <- try(rvest::session(.url), silent = TRUE)

    if (!is(x, "try-error")) {
      message("Reading: ", .url)
      ragnar::read_as_markdown(.url) |>
        ragnar::markdown_chunk() |>
        ragnar::ragnar_store_insert(store = store, chunks = _)
    }
  }
}


#'
#' Process degrees for RAG 
#' 

process_degrees <- function(.url, store) {
  lapply(X = .url, FUN = process_degree, store = store)
}