#'
#' Categories modules
#' 

categorise_modules <- function(modules, model) {
  chat <- ellmer::chat_ollama(
    system_prompt = "Categorise the following concepts. Make the categories succinct.",
    model = model
  )

  chat$chat_structured(
    modules, 
    type = ellmer::type_array(ellmer::type_string())
  )
}