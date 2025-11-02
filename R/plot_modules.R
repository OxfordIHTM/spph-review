#'
#' Plot core modules
#' 

plot_core_modules <- function(tab) {
  tab |>
    ggplot2::ggplot(
      mapping = ggplot2::aes(x = n, y = reorder(core_module, n))
    ) +
    ggplot2::geom_col(
      colour = oxthema::get_oxford_colour("sage"),
      fill = oxthema::get_oxford_colour("sage"),
      alpha = 0.8
    ) +
    ggplot2::geom_text(
      ggplot2::aes(label = paste0(n, " (", perc, ")")),
      nudge_x = 2.75, size = 5
    ) +
    ggplot2::scale_x_continuous(
      breaks = seq(from = 0, to = 30, by = 5), limits = c(0, 30)
    ) +
    ggplot2::labs(
      title = "Core module themes",
      subtitle = "Top 30 public health schools and programmes",
      x = NULL, y = "Core module themes"
    ) +
    oxthema::theme_oxford(
      grid = "X", grid_col = oxthema::get_oxford_colour("stone")
    )
}


#'
#' Plot option modules
#' 

plot_option_modules <- function(tab) {
  tab |>
    ggplot2::ggplot(
      mapping = ggplot2::aes(x = n, y = reorder(core_module, n))
    ) +
    ggplot2::geom_col(
      colour = oxthema::get_oxford_colour("sage"),
      fill = oxthema::get_oxford_colour("sage"),
      alpha = 0.8
    ) +
    ggplot2::geom_text(
      ggplot2::aes(label = paste0(n, " (", perc, ")")),
      nudge_x = 2.75, size = 5
    ) +
    ggplot2::scale_x_continuous(
      breaks = seq(from = 0, to = 30, by = 5), limits = c(0, 30)
    ) +
    ggplot2::labs(
      title = "Module options themes",
      subtitle = "Top 30 public health schools and programmes",
      x = NULL, y = "Module options themes"
    ) +
    oxthema::theme_oxford(
      grid = "X", grid_col = oxthema::get_oxford_colour("stone")
    )
}