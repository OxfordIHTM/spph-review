#'
#' Process degree for RAG
#' 

process_degree <- function(.url, store) {
  url_ok <- try(!httr::http_error(.url), silent = TRUE)
  url_can_read <- try(ragnar::read_as_markdown(.url), silent = TRUE)

  if (!is(url_ok, "try-error") & !is(url_can_read, "try-error")) {
    if (url_ok) {
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