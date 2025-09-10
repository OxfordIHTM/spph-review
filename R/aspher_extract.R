#'
#' Extract list of public health schools from ASPHER
#' 

aspher_extract_members_list <- function(.url, page) {
  .url <- paste0(.url, page)

  current_session <- rvest::session(.url)

  member_text <- rvest::html_elements(
    x = current_session, css = ".event .community_name"
  ) |>
    rvest::html_text2() |>
    stringr::str_split(pattern = "\n", simplify = TRUE) |>
    (\(x) x[ , 1:3])() |>
    data.frame() |>
    setNames(nm = c("department", "university", "location")) |>
    tibble::as_tibble() |>
    dplyr::mutate(
      department = stringr::str_remove_all(
        string = department, pattern = "\r"
      ) |>
        trimws(),
      university = stringr::str_remove_all(
        string = university, pattern = "\r"
      ) |>
        stringr::str_replace_all(
          pattern = "N/A", replacement = NA_character_
        ) |>
        trimws()
    )

  member_img <- rvest::html_elements(x = current_session, css = ".event img") |>
    rvest::html_attr(name = "src") |>
    (\(x) file.path("https://www.aspher.org", x))()

  member_link <- rvest::html_elements(
    x = current_session, css = ".event .community_name a"
  ) |>
    rvest::html_attr(name = "href") |>
    (\(x) file.path("https://www.aspher.org", x))()

  tibble::tibble(
    member_text,
    logo = member_img,
    link = member_link
  )
}


#'
#' Process raw ASPHER members list 
#' 

aspher_process_members_list <- function(members_list) {
  members_list$location[120] <- members_list$university[120]
  members_list$university[120] <- NA_character_

  members_list |>
    dplyr::mutate(
      department = stringr::str_replace(
        string = department, pattern = "CharitĂŠ", replacement = "Charité"
      ) |>
        stringr::str_replace(
          pattern = "PowiĹ\u009blaĹ\u0084ski", 
          replacement = "Powiślański"
        ) |>
        stringr::str_replace(pattern = "KoĂ§", replacement = "Koç") |>
        stringr::str_replace(pattern = "BoĹĄkin", replacement = "Boškin"),
      university = stringr::str_replace_all(
        string = university, pattern = "PalackĂ", replacement = "Palacký"
      ) |>
        stringr::str_replace(pattern = "CharitĂŠ", replacement = "Charité") |>
        stringr::str_replace(pattern = "LĂźneburg", replacement = "Lüneburg") |>
        stringr::str_replace(
          pattern = "PowiĹ\u009blaĹ\u0084ski", replacement = "Powiślański"
        ) |>
        stringr::str_replace(
          pattern = "LinkĹ\u0091ping", replacement = "Linköping"
        ) |>
        stringr::str_replace(pattern = "SkĂśvde", replacement = "Skövde") |>
        stringr::str_replace(pattern = "KoĂ§", replacement = "Koç")   
    )
}

