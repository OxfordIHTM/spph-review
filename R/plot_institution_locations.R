#'
#' Plot institutions locations
#' 

plot_institution_locations <- function(tab, area = c("country", "region")) {
  area <- match.arg(area)

  if (area == "country") {
    tab |>
      ggplot2::ggplot(mapping = ggplot2::aes(x = n, y = reorder(country, n))) +
      ggplot2::geom_col(
        colour = oxthema::get_oxford_colour("sage"),
        fill = oxthema::get_oxford_colour("sage"),
        alpha = 0.8
      ) +
      ggplot2::geom_text(
        mapping = ggplot2::aes(label = paste0(n, " (", perc, ")")),
        nudge_x = 1.25, size = 5
      ) +
      scale_x_continuous(
        breaks = seq(from = 0, to = 15, by = 3), limits = c(0, 15)
      ) +
      ggplot2::labs(
        title = "Top 30 Public Health Schools and Programmes by Country",
        x = NULL, y = "Country"
      ) +
      oxthema::theme_oxford(
        grid = "X", grid_col = oxthema::get_oxford_colour("stone")
      )
  } else {
    tab |>
      ggplot2::ggplot(
        mapping = ggplot2::aes(x = n, y = reorder(un_region, n))
      ) +
      ggplot2::geom_col(
        colour = oxthema::get_oxford_colour("sage"),
        fill = oxthema::get_oxford_colour("sage"),
        alpha = 0.8
      ) +
      ggplot2::geom_text(
        mapping = ggplot2::aes(label = paste0(n, " (", perc, ")")),
        nudge_x = 1.25, size = 5
      ) +
      scale_x_continuous(
        breaks = seq(from = 0, to = 20, by = 5), limits = c(0, 20)
      ) +
      ggplot2::labs(
        title = "Top 30 Public Health Schools and Programmes by UN Regions",
        x = NULL, y = "UN Region"
      ) +
      oxthema::theme_oxford(
        grid = "X", grid_col = oxthema::get_oxford_colour("stone")
      )
  }
}