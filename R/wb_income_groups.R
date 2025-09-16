#'
#' 
#'

wb_download_income_groups <- function(destdir, overwrite = FALSE) {
  if (!dir.exists(destdir)) {
    dir.create(path = destdir)
  }

  file_path <- file.path(destdir, "wb_income_groups.xlsx")

  if (!file.exists(file_path) | overwrite) {
    download.file(
      url = "https://ddh-openapi.worldbank.org/resources/DR0095333/download",
      destfile = file_path, mode = "wb"
    )
  }

  file_path
}


wb_read_income_groups <- function(wb_file) {
  readxl::read_xlsx(path = wb_file, col_types = "text") |>
    dplyr::select(Code, `Income group`) |>
    setNames(nm = c("iso3c", "income_group"))
}    