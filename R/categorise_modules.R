#'
#' Create module categories
#' 

create_module_categories <- function(modules, model) {
  chat <- ellmer::chat_ollama(
    system_prompt = "You are a terse assistant. Categorise the following concepts. Make the categories succinct.",
    model = model
  )

  chat$chat_structured(
    modules, 
    type = ellmer::type_array(ellmer::type_string())
  )
}


#'
#' Categorise modules
#' 

categorise_module <- function(module, module_categories, model) {
  chat <- ellmer::chat_ollama(
    system_prompt = "You are a terse assistant. Assign a category to the given text from the provided categories.",
    model = model
  )

  # type_category <- ellmer::type_object(
  #   category = ellmer::type_enum(
  #     values = module_categories,
  #     description = "Category to assign to the given text"
  #   )
  # ) |>
  #   ellmer::type_array()

  df <- chat$chat_structured(
    module, 
    type = ellmer::type_enum(
      values = module_categories,
      description = "Category to assign to the given text"
    ) |>
      ellmer::type_array()
  )

  df
}


