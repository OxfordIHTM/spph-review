#'
#' Expand categories
#' 

expand_category <- function(module_category, module) {
  grepl(pattern = module_category, x = module) |>
    as.numeric()
}

expand_categories <- function(module_category, module) {
  lapply(
    X = module_category,
    FUN = expand_category,
    module = module
  ) |>
    (\(x) { names(x) <- module_category; x })() |>
    do.call(cbind, args = _) |>
    tibble::as_tibble()
}