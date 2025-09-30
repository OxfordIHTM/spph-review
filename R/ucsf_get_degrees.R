#'
#' Get UCSF public health degrees information
#' 

ucsf_get_master_programme_links <- function(.url) {
  current_session <- rvest::session(url = .url)
  
  degree_name <- c(
    current_session |>
      rvest::html_elements(css = ".ck-widget .column1") |>
      rvest::html_text2() |>
      (\(x) x[3])() |>
      stringr::str_split(pattern = "\n\n") |>
      unlist() |>
      (\(x)
        {
          ifelse(
            grepl(pattern = "MS", x = x),
            gsub(pattern = "\\sMS", x = x, replacement = "") |>
              (\(x) paste("Master of Science in", x))(),
            x
          )
        }
      )(),
    current_session |>
      rvest::html_elements(css = ".ck-widget .column2") |>
      rvest::html_text2() |>
      (\(x) x[3])() |>
      stringr::str_split(pattern = "\n\n") |>
      unlist() |>
      (\(x)
        {
          x <- ifelse(
            grepl(pattern = "MS", x = x),
            gsub(pattern = "\\sMS", x = x, replacement = "") |>
              (\(x) paste("Master of Science in", x))(),
            x
          )
        
          x <- ifelse(
            grepl(pattern = "MA", x = x),
            gsub(pattern = "\\sMA", x = x, replacement = "") |>
              (\(x) paste("Master of Arts in", x))(),
            x
          )
        
          x <- ifelse(
            grepl(pattern = "MEPN", x = x),
            gsub(pattern = "\\sMEPN", x = x, replacement = "") |>
              (\(x) paste("Master's Entry Programe in", x))(),
            x
          )
        
          x <- ifelse(
            grepl(pattern = "MTM", x = x),
            gsub(
              pattern = "\\sMTM\\s\\(joint with UC Berkeley\\)", x = x, 
              replacement = ""
            ) |>
              (\(x) paste("Master of", x))(),
            x
          )
          
          x
        }
      )()
  )

  programme_link <- c(
    current_session |>
      rvest::html_elements(css = ".ck-widget .column1 a") |>
      rvest::html_attr(name = "href") |>
      (\(x) x[12:18])() |>
      (\(x) paste0("https://graduate.ucsf.edu/academics/masters-degree", x))(),
    current_session |>
      rvest::html_elements(css = ".ck-widget .column2 a") |>
      rvest::html_attr(name = "href") |>
      (\(x) x[10:15])() |>
      (\(x) ifelse(grepl(pattern = "https", x = x), x, paste0("https://graduate.ucsf.edu/academics/masters-degree", x)))()
  )

  rbind(
    tibble::tibble(
      department = NA_character_,
      degree = degree_name,
      url = programme_link
    ),
    tibble::tribble(
      ~department, ~degree, ~url,
      "School of Nursing and Health Professions", 
      "Master of Public Health", 
      "https://www.usfca.edu/nursing/programs/graduate/public-health/applied-practice-integrated-learning-experience"
    )
  ) |>
    (\(x) x[c(3, 5:8, 13:14), ])() |>
    dplyr::mutate(
      institution = "University of California, San Francisco",
      .before = department
    )
}