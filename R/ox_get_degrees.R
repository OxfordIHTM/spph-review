#'
#' Get Oxford University degree programme information
#' 

ox_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)

  department_name <- current_session |>
    rvest::html_elements(css = ".course-cell .course-department") |>
    rvest::html_text2()

  degree_name <- current_session |>
    rvest::html_elements(css = ".course-cell .course-title") |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(css = ".course-cell .course-title a") |>
    rvest::html_attr(name = "href") |>
    (\(x) paste0("https://www.ox.ac.uk", x))()

  tibble::tibble(
    institution = "University of Oxford",
    department = department_name,
    degree = degree_name,
    url = programme_link
  ) |>
    (\(x) x[c(1, 8:9, 14:16, 19, 21, 23:24, 47:48, 51), ])()
}


#'
#' Setup RAG store for Oxford University degrees
#' 

ox_create_store <- function(.url, store) {
  ragnar::read_as_markdown(.url) |>
    ragnar::markdown_chunk() |>
    ragnar::ragnar_store_insert(store = store, chunks = _)

  ragnar::ragnar_store_build_index(store)
}


#'
#' Retrieve information from Oxford RAG store
#' 

ox_retrieve_info <- function() {
  
}