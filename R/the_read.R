#'
#' Read THE rankings PDF
#' 

the_read_rankings <- function(path, pages) {
  df_text <- pdftools::pdf_text(pdf = path) |>
    (\(x) x[pages[[1]]])() |>
    stringr::str_split(pattern = "\n") |>
    list()

  names(df_text) <- names(pages)

  df_text
}


#'
#' Process THE rankings text
#' 

the_process_rankings <- function(the_text) {
  x <- lapply(
    X = the_text[[1]],
    FUN = function(x) {
      x <- x[!grepl(pattern = "Times Higher Education", x = x)]
      x <- x[grepl(pattern = "^[1-9]{1,}|^\\s{1,}[1-9]{1,}", x = x)] |>
        stringr::str_replace_all(pattern = "^\\s{18,21}", replacement = ";") |>
        stringr::str_replace_all(pattern = "\\s{3,}", replacement = ";") |>
        stringr::str_replace(pattern = "\\b \\b", replacement = ";")
    }
  ) |>
    unlist() 
  
  if (names(the_text) == 2023) {
    x <- x[1:836]
  }
  
  x |>
    stringr::str_split(pattern = ";", simplify = TRUE) |>
    (\(x) x[ , 1:10])() |>
    data.frame() |>
    setNames(
      nm = c(
        "current_rank", "previous_rank", "institution", "country_territory",
        "teaching", "research_environment", "research_quality", "industry",
        "international_outlook", "overall_score"
      )
    ) |>
    tibble::as_tibble() |>
    dplyr::mutate(
      current_rank = trimws(current_rank) |>
        (\(x) ifelse(x == "", NA_character_, x))()
    ) |>
    tidyr::fill(current_rank) |>
    dplyr::mutate(year = names(the_text), .before = current_rank)
}


#'
#' Extract THE rankings from PDF
#' 

the_extract_rankings <- function(path, pages) {
  
}



#'
#' Set THE rankings file pages to extract from
#' 

the_set_ranking_pages <- function() {
  list(
    "2025" = c(
      19, 21, 25, 27, 39, 41, 43, 45, 48, 49, 53, 55, 57, 59, 62, 63, 65, 67,
      70, 71
    ),
    "2024" = c(
      23, 27, 29, 33, 41, 43, 44, 45, 49, 51, 55, 57, 61, 63, 65, 67, 70, 73,
      76, 77
    ),
    "2023" = c(
      27, 29, 31, 35, 42, 43, 46, 47, 50, 51, 54, 55, 60, 61, 64, 65, 68, 69,
      72, 73
    ),
    "2022" = c(
      21, 23, 25, 27, 37, 39, 41, 43, 45, 47, 49, 50, 55, 57, 59, 61, 65, 67,
      69, 70
    ),
    "2021" = c(
      19, 21, 23, 25, 39, 41, 43, 44, 47, 49, 53, 54, 57, 59, 63, 65, 66, 69,
      71, 74
    )
  )
}