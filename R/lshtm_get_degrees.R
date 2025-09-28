#'
#' Get LSHTM public health degrees information
#' 

lshtm_get_master_programme_links <- function(.url, 
                                             html = "data-raw/lshtm/lshtm.html") {
  if (!httr::http_error(.url)) {
    current_session <- rvest::session(
      url = .url, 
      httr::user_agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36")
    )
  } else {
    current_session <- rvest::read_html(html)
  }
  
  degree_name <- current_session |>
    rvest::html_elements(css = "td a") |>
    rvest::html_text2()

  programme_link <- current_session |>
    rvest::html_elements(css = "td a") |>
    rvest::html_attr(name = "href")

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}


#'
#' Download LSHTM website HTML
#' 

lshtm_gdrive_download <- function(gdrive_id, file_path, overwrite = FALSE) {
  if (!file.exists(file_path) | overwrite) {
    if (!dir.exists(dirname(file_path))) {
      dir.create(dirname(file_path), showWarnings = FALSE)
    }

    googledrive::drive_ls(
      path = googledrive::as_id(gdrive_id), pattern = "html"
    ) |>
      googledrive::drive_download(path = file_path)
  }

  file_path
}