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
    (\(x) tibble::tibble(year = df_year, x))() |>
    dplyr::mutate(
      institution = dplyr::case_when(
        grepl(pattern = "UCL", x = institution) ~ "University College London",
        grepl(pattern = "ETH", x = institution) ~ "ETH Zurich - Swiss Federal Institute of Technology",
        grepl(pattern = "NTU", x = institution) ~ "Nanyang Technological University, Singapore",
        grepl(pattern = "MIT", x = institution) ~ "Massachusetts Institute of Technology",
        grepl(pattern = "UNSW", x = institution) ~ "The University of New South Wales",
        grepl(pattern = "NUS", x = institution) ~ "National University of Singapore",
        grepl(pattern = "UCB", x = institution) ~ "University of California, Berkeley",
        grepl(pattern = "Caltech", x = institution) ~ "California Institute of Technology",
        grepl(pattern = "KCL", x = institution) ~ "King's College London",
        grepl(pattern = "LSE", x = institution) ~ "London School of Economics and Political Science",
        grepl(pattern = "Universiti Malaya \\(UM\\)", x = institution) ~ "Universiti Malaya",
        grepl(pattern = "UCSD", x = institution) ~ "University of California, San Diego",
        grepl(pattern = "Sorbonne", x = institution) ~ "Sorbonne University",
        grepl(pattern = "Karlsruhe", x = institution) ~ "Karlsruhe Institute of Technology",
        grepl(pattern = "UZH", x = institution) ~ "University of Zurich",
        grepl(pattern = "NYU", x = institution) ~ "New York University",
        grepl(pattern = "POSTECH", x = institution) ~ "Pohang University of Science and Technology",
        grepl(pattern = "Universidade de São Paulo \\(USP\\)", x = institution) ~ "Universidade de São Paulo",
        grepl(pattern = "QMUL", x = institution) ~ "Queen Mary University of London",
        grepl(pattern = "IITD", x = institution) ~ "Indian Institute of Technology Delhi",
        grepl(pattern = "UKM", x = institution) ~ "Universiti Kebangsaan Malaysia",
        grepl(pattern = "IITB", x = institution) ~ "Indian Institute of Technology Bombay",
        grepl(pattern = "Universiti Putra Malaysia", x = institution) ~ "Universiti Putra Malaysia",
        grepl(pattern = "Universiti Sains Malaysia", x = institution) ~ "Universiti Sains Malaysia",
        grepl(pattern = "UNAM", x = institution) ~ "Universidad Nacional Autónoma de México",
        grepl(pattern = "UTM", x = institution) ~ "Universiti Teknologi Malaysia",
        grepl(pattern = "KAU", x = institution) ~ "King Abdul Aziz University",
        grepl(pattern = "UCSB", x = institution) ~ "University of California, Santa Barbara",
        grepl(pattern = "IITM", x = institution) ~ "Indian Institute of Technology Madras",
        grepl(pattern = "ITESM", x = institution) ~ "Tecnológico de Monterrey",
        grepl(pattern = "NCKU", x = institution) ~ "National Cheng Kung University",
        grepl(pattern = "Kharagpur", x = institution) ~ "Indian Institute of Technology Kharagpur",
        grepl(pattern = "IISc", x = institution) ~ "Indian Institute of Science Bangalore",
        grepl(pattern = "Kanpur", x = institution) ~ "Indian Institute of Technology Kanpur",
        grepl(pattern = "ULB", x = institution) ~ "Université Libre de Bruxelles",
        grepl(pattern = "Unicamp", x = institution) ~ "Universidade Estadual de Campinas",
        grepl(pattern = "AUB", x = institution) ~ "American University of Beirut",
        grepl(pattern = "UTP", x = institution) ~ "Universiti Teknologi Petronas",
        grepl(pattern = "ITB", x = institution) ~ "Bandung Institute of Technology",
        grepl(pattern = "AUS", x = institution) ~ "American University of Sharjah",
        grepl(pattern = "VUB", x = institution) ~ "Vrije Universiteit Brussel",
        grepl(pattern = "CUHK", x = institution) ~ "The Chinese University of Hong Kong",
        grepl(pattern = "KAIST", x = institution) ~ "Korea Advanced Institute of Science & Technology",
        grepl(pattern = "Universidad de Buenos Aires", x = institution) ~ "Universidad de Buenos Aires",
        grepl(pattern = "Tokyo Tech", x = institution) ~ "Tokyo Institute of Technology",
        grepl(pattern = "Pontificia Universidad", x = institution) ~ "Pontificia Universidad Católica de Chile",
        grepl(pattern = "TU Berlin", x = institution) ~ "Technische Universität Berlin",
        grepl(pattern = "UON", x = institution) ~ "The University of Newcastle, Australia",
        grepl(pattern = "IITG", x = institution) ~ "Indian Institute of Technology Guwahati",
        grepl(pattern = "IITR", x = institution) ~ "Indian Institute of Technology Roorkee",
        grepl(pattern = "SUSTech", x = institution) ~ "Southern University of Science and Technology",
        grepl(pattern = "Taiwan Tech", x = institution) ~ "National Taiwan University of Science and Technology",
        grepl(pattern = "Technion", x = institution) ~ "Israel Institute of Technology",
        grepl(pattern = "Virginia Tech", x = institution) ~ "Virginia Polytechnic Institute",
        grepl(pattern = "UCAS", x = institution) ~ "University of Chinese Academy of Sciences",
        grepl(pattern = "UBD", x = institution) ~ "Universiti Brunei Darussalam",
        grepl(pattern = "DGIST", x = institution) ~ "Daegu Gyeongbuk Institute of Science and Technology",
        grepl(pattern = "UEA", x = institution) ~ "University of East Anglia",
        grepl(pattern = "Gwangju", x = institution) ~ "Gwangju Institute of Science and Technology",
        grepl(pattern = "BUAA", x = institution) ~ "Beihang University",
        grepl(pattern = "LUT", x = institution) ~ "Lappeenranta-Lahti University of Technology",
        grepl(pattern = "INSA", x = institution) ~ "Institut National des Sciences Appliquées de Lyon",
        grepl(pattern = "SUNY", x = institution) ~ "University at Buffalo The State University of New York",
        grepl(pattern = "Università  degli Studi di Pavia", x = institution) ~ "Università degli Studi di Pavia",
        grepl(pattern = "HSE, Moscow", x = institution) ~ "National Research University Higher School of Economics",
        grepl(pattern = "UNESP", x = institution) ~ "Universidade Estadual Paulista Júlio de Mesquita Filho",
        grepl(pattern = "TIIAME-NRU", x = institution) ~ "Tashkent Institute of Irrigation and Agricultural Mechanization Engineers - National Research University",
        grepl(pattern = "USACH", x = institution) ~ "Universidad de Santiago de Chile",
        grepl(pattern = "Dammam", x = institution) ~ "Imam Abdulrahman Bin Faisal University",
        grepl(pattern = "UUM", x = institution) ~ "Universiti Utara Malaysia",
        grepl(pattern = "CQUniversity", x = institution) ~ "Central Queensland University Australia",
        grepl(pattern = "ITS", x = institution) ~ "Institut Teknologi Sepuluh Nopember",
        grepl(pattern = "UNPAD", x = institution) ~ "Universitas Padjadjaran",
        grepl(pattern = "UiTM", x = institution) ~ "Universiti Teknologi MARA",
        .default = institution
      )
    )
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