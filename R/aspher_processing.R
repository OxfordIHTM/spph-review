#'
#' Process ASPHER member info for RAG
#' 

aspher_process_member <- function(.url, store) {
  ragnar::read_as_markdown(.url) |>
    ragnar::markdown_chunk() |>
    ragnar::ragnar_store_insert(store = store, chunks = _)
} 



aspher_extract_member_info <- function(.url) {
  current_session <- rvest::session(.url)

  rvest::html_elements(x = current_session, css = "#right_col #users_data") |>
    rvest::html_text() |>
    stringr::str_split(pattern = "\r\n") |>
    (\(x)
      {
        user_text <- x[[1]]
        user_text[2:length(user_text)] |>
          stringr::str_remove(pattern = "ASPHER DIRECTORY\n\t\t")
      }
    )()
}