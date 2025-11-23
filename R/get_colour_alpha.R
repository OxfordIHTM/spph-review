#'
#' Get alpha of colour
#' 

get_alpha_colour <- function(hex) {
  x <- hex |>
    col2rgb()

  rgb(
    red = x[1], green = x[2], blue = x[3], 
    alpha = 20 * 255 / 100, maxColorValue = 255
  )
}
