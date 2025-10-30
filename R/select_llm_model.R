#'
#' Check for appropriate Ollama model available
#' 

select_llm_model <- function(src) {
  llm_models <- ollamar::list_models()
  
  mod <- grepv(pattern = src, x = llm_models$name)

  if (length(mod) == 0) {
    stop("No model in Ollama matches your search term. Try again.")
  }

  if (length(mod) > 1) {
    warning(
      "There are ", length(mod), 
      " models in Ollama that match your search term. Returning the first one."
    )
    mod <- mod[1]
  }

  mod
}