#'
#' Write output file as CSV
#' 

write_csv_file <- function(x, file, overwrite = FALSE) {
  if (!dir.exists(dirname(file))) {
    dir.create(dirname(file), showWarnings = FALSE)

    write.csv(x = x, file = file, row.names = FALSE)
  } else {
    if (!file.exists(file) | overwrite) {
      write.csv(x = x, file = file, row.names = FALSE)
    }
  }

  file
}