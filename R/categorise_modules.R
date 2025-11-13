#'
#' Create module categories
#' 

create_module_categories <- function(modules, model) {
  chat <- ellmer::chat_ollama(
    system_prompt = "
      You are a terse assistant.
      Categorise the following concepts. 
      Make the categories succinct.
    ",
    model = model
  )

  chat$chat_structured(
    modules, 
    type = ellmer::type_array(ellmer::type_string())
  )
}


# create_module_categories <- function(modules, model) {
#   system_prompt <- "
#     You are a terse assistant. Create categories that will summarise the
#     concepts provided by the user. Make the categories succinct.
#   "

#   chat <- ellmer::chat_ollama(
#     system_prompt = system_prompt,
#     model = model
#   )

#   chat$chat_structured(
#     modules,
#     type = ellmer::type_object(
#       "Categories",
#       category = ellmer::type_array(ellmer::type_string())
#     )
#   )
# }


#'
#' Categorise modules
#' 

categorise_module <- function(module, module_categories, model) {
  system_prompt <- "
    You are a terse assistant.
    Classify the text provided by the user into the most appropriate category
    from one of the given categories.
  "

  chat <- ellmer::chat_ollama(
    system_prompt = system_prompt,
    model = model,
    params = ellmer::params(temperature = 0.1)
  )

  type_category <- ellmer::type_object(
    category = ellmer::type_enum(
      values = module_categories,
      description = "Category name"
    )
  )

  df <- try(chat$chat_structured(module, type = type_category))

  if (is(df, "try-error")) df <- NA_character_

  df
}


# categorise_module <- function(module, module_categories, model) {
#   system_prompt = paste0(
#     "You are a terse assistant. Classify ", module, 
#     " into one of the following categories: ", 
#     paste(module_categories, collapse = ", "), "."
#   )

#   chat <- ellmer::chat_ollama(model = model)

#   chat$chat(system_prompt)
# }


add_module_core_categories <- function(ph_review_data, 
                                       ph_modules_category, 
                                       collapse = FALSE) {
  ph_review_data_expanded <- expand_module(ph_review_data, type = "core")
  
  df <- ph_review_data_expanded |>
    dplyr::mutate(
      modules_core_category = unlist(ph_modules_category), 
      .after = modules_core
    ) |>
    dplyr::mutate(
      modules_core_category = ifelse(
        grepl(
          pattern = "Epidem|epidem|Statistic|statistic", 
          x = modules_core
        ),
        "Epidemiology and Statistics",
        modules_core_category
      )
    )
  
  if (collapse) {
    modules_core_category <- df |>
      dplyr::summarise(
        modules_core_category = paste(
          unique(modules_core_category), collapse = "; "),
        .by = institution
      ) |>
      dplyr::pull(modules_core_category)

    df <- ph_review_data |>
      dplyr::mutate(
        modules_core_category = modules_core_category, .after = modules_core
      )
  }

  df
}



add_module_options_categories <- function(ph_review_data, 
                                          ph_modules_option_category, 
                                          collapse = FALSE) {
  ph_review_data_expanded <- expand_module(ph_review_data, type = "option")
  
  df <- ph_review_data_expanded |>
    dplyr::mutate(
      modules_options_category = unlist(ph_modules_option_category), 
      .after = modules_options
    ) |>
    dplyr::mutate(
      modules_options_category = ifelse(
        grepl(
          pattern = "Epidem|epidem|Statistic|statistic", 
          x = modules_options
        ),
        "Epidemiology and Biostatistics",
        modules_options_category
      )
    )
  
  if (collapse) {
    modules_options_category <- df |>
      dplyr::summarise(
        modules_options_category = paste(
          unique(modules_options_category), collapse = "; "
        ),
        .by = institution
      ) |>
      dplyr::pull(modules_options_category)

    df <- ph_review_data |>
      dplyr::mutate(
        modules_options_category = modules_options_category, 
        .after = modules_options
      )
  }

  df
}

