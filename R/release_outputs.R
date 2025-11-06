#'
#' Release RAG database
#' 

release_rag_db <- function(file,
                           tag = NULL, 
                           name,
                           type = c("major", "minor", "patch")) {
  type <- match.arg(type)

  if (!is.null(tag)) {
    prev_release_tag <- piggyback::pb_releases() |>
      dplyr::slice(1) |>
      dplyr::pull(tag_name) |>
      stringr::str_split(pattern = "\\.")

    if (type == "major") {
      tag <- prev_release_tag

      tag[1] <- tag[1] |>
        stringr::str_replace(
          pattern = "[0-9]", 
          replacement = stringr::str_extract(
            string = tag[1], pattern = "[0-9]"
          ) |>
            as.numeric() |>
            sum(1) |>
            as.character()
        )
      
      tag[2] <- 0
      tag[3] <- 0

      tag <- paste(tag, collapse = ".")
    }

    if (type == "minor") {
      tag <- prev_release_tag

      tag[2] <- tag[2] |>
        stringr::str_replace(
          pattern = "[0-9]", 
          replacement = stringr::str_extract(
            string = tag[2], pattern = "[0-9]"
          ) |>
            as.numeric() |>
            sum(1) |>
            as.character()
        )
      
      tag[3] <- 0

      tag <- paste(tag, collapse = ".")
    }

    if (type == "patch") {
      tag <- prev_release_tag

      tag[3] <- tag[3] |>
        stringr::str_replace(
          pattern = "[0-9]", 
          replacement = stringr::str_extract(
            string = tag[3], pattern = "[0-9]"
          ) |>
            as.numeric() |>
            sum(1) |>
            as.character()
        )
      
      tag <- paste(tag, collapse = ".")
    }
  }
  
  tag <- paste(
    tools::file_path_sans_ext(name),
    Sys.Date() |> 
      gsub(pattern = "-", replacement = "", x = _),
    sep = "-"
  )

  releases <- piggyback::pb_releases()

  if (ncol(releases) == 0) {
    piggyback::pb_new_release(
      tag = tag,
      name = paste0(
        "Schools and Programmes of Public Health Review ",
         tag
      ),
      body = "Database release"
    )
  }
  
  if (!tag %in% releases$tag_name) {
    piggyback::pb_new_release(
      tag = tag,
      name = paste0(
        "Schools and Programmes of Public Health Review ",
        tag
      ),
      body = "Database release"
    )
  }

  Sys.sleep(time = 60)

  piggyback::pb_upload(file = file, name = name, tag = tag)
}


#'
#' Release review data
#' 

release_review_data <- function(file, name) {
  piggyback::pb_upload(file = file, name = name)
}


#'
#' Release names
#' 

release_names <- c(
  "ṣiḥḥah", "jiànkāng", "gezondheid", "santé", "gesundheit", "hygeia", 
  "salute", "kenkō", "zdrowie", "saúde", "zdorov'ye", "salud", "hälsa", 
  "sağlık", "sức khỏe"
)
