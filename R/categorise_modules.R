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


create_module_categories <- function(modules, model) {
  system_prompt <- paste0(
    "You are a terse assistant. Create categories that will summarise the following concepts: ",
    modules, ". Make the categories succinct."
  )

  chat <- ellmer::chat_ollama(model = model)

  #chat$chat(system_prompt)
  chat$chat_structured(
    system_prompt,
    type = ellmer::type_object(
      "Categories",
      category = ellmer::type_array(ellmer::type_string())
    )
  )
}


#'
#' Categorise modules
#' 

categorise_module <- function(module, module_categories, model) {
  chat <- ellmer::chat_ollama(model = model)

  type_category <- ellmer::type_object(
    category = ellmer::type_enum(
      values = module_categories,
      description = "Category name"
    )
  )

  df <- try(chat$chat_structured(module, type = type_category))

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


