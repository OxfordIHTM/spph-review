#'
#' Read QS rankings Excel sheet
#' 

qs_read_overall_rankings <- function(qs_file) {
  qs_year <- stringr::str_extract(string = qs_file, pattern = "[0-9]{4}")

  skip <- ifelse(qs_year == "2026", 2, 3)

  readxl::read_xlsx(path = qs_file, skip = skip) |>
    list() |>
    setNames(nm = qs_year)
}


#'
#' Process QS rankings data
#' 

qs_process_overall_rankings <- function(qs_data) {
  df_year <- names(qs_data) |>
    stringr::str_extract(pattern = "[0-9]{4}")

  qs_data[[1]] |>
    setNames(nm = qs_create_variable_names()[[df_year]]) |>
    (\(x) tibble::tibble(year = df_year, x))()
}




#'
#' Name QS rankings variables
#' 

qs_create_variable_names <- function() {
  list(
    "2022" = c(
      "rank_country", "rank_region", "rank_current", "rank_previous",
      "institution", "country_code", "country_name", "size", "focus", 
      "research", "age_band", "status", "ar_score", "ar_rank", "er_score", 
      "er_rank", "fsr_score", "fsr_rank", "cpf_score", "cpf_rank", "ifr_score",
      "ifr_rank", "isr_score", "isr_rank", "overall_score"
    ),
    "2023" = c(
      "rank_current", "rank_previous", "institution", "country_code", 
      "country_name", "size", "focus", "research", "age_band", "status",
      "ar_score", "ar_rank", "er_score", "er_rank", "fsr_score", "fsr_rank", 
      "cpf_score", "cpf_rank", "ifr_score", "ifr_rank", "isr_score", "isr_rank",
      "irn_score", "irn_rank", "ger_score", "ger_rank", "overall_score"
    ),
    "2024" = c(
      "rank_current", "rank_previous", "institution", "country_code", 
      "country_name", "size", "focus", "research", "status", "ar_score",
      "ar_rank", "er_score", "er_rank", "fsr_score", "fsr_rank", "cpf_score", 
      "cpf_rank", "ifr_score", "ifr_rank", "isr_score", "isr_rank", "irn_score", 
      "irn_rank", "ger_score", "ger_rank", "sus_score", "sus_rank", 
      "overall_score"
    ),
    "2025" = c(
      "index", "rank_current", "rank_previous", "institution", "country_code", 
      "country_name", "size", "focus", "research", "status", "ar_score",
      "ar_rank", "er_score", "er_rank", "fsr_score", "fsr_rank", "cpf_score", 
      "cpf_rank", "ifr_score", "ifr_rank", "isr_score", "isr_rank", "irn_score", 
      "irn_rank", "ger_score", "ger_rank", "sus_score", "sus_rank", 
      "overall_score"
    ),
    "2026" = c(
      "index", "rank_current", "rank_previous", "institution", "country_code", 
      "country_name", "size", "focus", "research", "status", "ar_score",
      "ar_rank", "er_score", "er_rank", "fsr_score", "fsr_rank", "cpf_score", 
      "cpf_rank", "ifr_score", "ifr_rank", "isr_score", "isr_rank", "isd_score",
      "isd_rank", "irn_score", "irn_rank", "ger_score", "ger_rank", "sus_score", 
      "sus_rank", "overall_score"
    )   
  )
}