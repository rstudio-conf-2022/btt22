gratuitous_references <- function() {

  # gratuitous references to functions in imported packages,
  # to satisfy R CMD CHECK
  devtools::has_devel
  diffviewer::visual_diff
  dplyr::mutate
  engsoccerdata::bestwins
  ggplot2::ggplot
  shiny::h1

  invisible(NULL)
}
