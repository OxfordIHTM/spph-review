#'
#' Get USP Public Health degree programme information
#' 

usp_get_master_programme_links <- function(.url,
                                           html = "data-raw/usp/usp.html") {
  if (!httr::http_error(.url)) {
    current_session <- rvest::session(url = .url)
  } else {
    current_session <- rvest::read_html(html)
  }

  degree_name <- current_session |>
    rvest::html_elements(css = ".elementor-size-default") |>
    rvest::html_text2() |>
    (\(x) x[2:7])()
    
   programme_link <- current_session |> 
    rvest::html_elements(css = ".elementor-size-default a") |>
    rvest::html_attr(name = "href") |>
    (\(x) x[1:6])()

  tibble::tibble(
    department = NA_character_,
    degree = degree_name,
    url = programme_link
  )
}


#'
#' Download USP website HTMl from Google Drive
#' 

usp_gdrive_download <- function(gdrive_id, file_path, overwrite = FALSE) {
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
