
as_inline_svg <- function(svg) {
  paste0("data:image/svg+xml;utf8,", svg)
}

make_testcase_file <- function(fig_name) {
  file <- tempfile(fig_name, fileext = ".svg")
  structure(file, class = "vdiffr_testcase")
}

get_aliases <- function() {
  aliases <- fontquiver::font_families("Liberation")
  aliases$symbol$symbol <- fontquiver::font_symbol("Symbola")
  aliases
}

write_svg <- function(p, file, title, user_fonts) {
  ver <- gdtools::version_freetype()
  if (ver < "2.6") {
    stop(call. = FALSE,
      "vdiffr requires FreeType >= 2.6.0. Current version: ", ver
    )
  }

  user_fonts <- user_fonts %||% get_aliases()
  svglite::svglite(file, user_fonts = user_fonts)
  on.exit(grDevices::dev.off())
  print_plot(p, title)
}

print_plot <- function(p, title) {
  UseMethod("print_plot")
}

print_plot.default <- function(p, title) {
  print(p)
}

print_plot.ggplot <- function(p, title) {
  add_dependency("ggplot2")
  if (!"title" %in% names(p$labels)) {
    p <- p + ggplot2::ggtitle(title)
  }
  if (!length(p$theme)) {
    p <- p + theme_test()
  }
  print(p)
}

print_plot.recordedplot <- function(p, title) {
  grDevices::replayPlot(p)
}

print_plot.function <- function(p, title) {
  p()
}

# 'width' and 'height' attributes are necessary for correctly drawing
# a SVG into a canvas
svg_add_dims <- function(svg) {
  inline_pattern <- "^data:image/svg\\+xml;utf8,"
  is_inline <- grepl(inline_pattern, svg)

  if (is_inline) {
    tmp <- gsub(inline_pattern, "", svg)
  } else {
    tmp <- svg
  }

  xml <- xml2::read_xml(tmp)

  # Check if height or width are already defined, because the hack
  # below would create duplicates
  dim_attrs <- map(c("height", "width"), partial(xml2::xml_attr, xml))

  if (all(is.na(dim_attrs))) {
    viewbox <- strsplit(xml2::xml_attr(xml, "viewBox"), " ")[[1]]
    natural_width <- viewbox[[3]]
    natural_height <- viewbox[[4]]

    replacement <- sprintf("<svg width='%s' height='%s' ",
      natural_width, natural_height)

    # Ugly hack until xml2 can modify nodes
    svg <- gsub("<svg ", replacement, tmp)

    if (is_inline) {
      svg <- as_inline_svg(svg)
    }
  }

  svg
}

theme_test <- function(...) {
  theme <- theme_test_legacy(...)
  if (utils::packageVersion("ggplot2") > "2.1.0") {
    theme <- theme + theme_test_recent(...)
  }
  theme
}

theme_test_legacy <- function(base_size = 11, base_family = "") {
  half_line <- base_size / 2

  ggplot2::theme(
    line =               ggplot2::element_line(colour = "black", size = 0.5, linetype = 1,
                            lineend = "butt"),
    rect =               ggplot2::element_rect(fill = "white", colour = "black",
                            size = 0.5, linetype = 1),
    text =               ggplot2::element_text(
                            family = base_family, face = "plain",
                            colour = "black", size = base_size,
                            lineheight = 0.9, hjust = 0.5, vjust = 0.5, angle = 0,
                            margin = ggplot2::margin(), debug = FALSE
                         ),

    axis.line =          ggplot2::element_blank(),
    axis.line.x =        NULL,
    axis.line.y =        NULL,
    axis.text =          ggplot2::element_text(size = ggplot2::rel(0.8), colour = "grey30"),
    axis.text.x =        ggplot2::element_text(margin = ggplot2::margin(t = 0.8 * half_line / 2), vjust = 1),
    axis.text.y =        ggplot2::element_text(margin = ggplot2::margin(r = 0.8 * half_line / 2), hjust = 1),
    axis.ticks =         ggplot2::element_line(colour = "grey20"),
    axis.ticks.length =  grid::unit(half_line / 2, "pt"),
    axis.title.x =       ggplot2::element_text(
                           margin = ggplot2::margin(t = half_line),
                           vjust = 1
                         ),
    axis.title.y =       ggplot2::element_text(
                           angle = 90,
                           margin = ggplot2::margin(r = half_line),
                           vjust = 1
                         ),
    legend.background =  ggplot2::element_rect(colour = NA),
    legend.margin =      ggplot2::margin(0, 0, 0, 0, "cm"),
    legend.key =         ggplot2::element_rect(fill = "white", colour=NA),
    legend.key.size =    grid::unit(1.2, "lines"),
    legend.key.height =  NULL,
    legend.key.width =   NULL,
    legend.text =        ggplot2::element_text(size = ggplot2::rel(0.8)),
    legend.text.align =  NULL,
    legend.title =       ggplot2::element_text(hjust = 0),
    legend.title.align = NULL,
    legend.position =    "right",
    legend.direction =   NULL,
    legend.justification = "center",
    legend.box =         NULL,
    panel.background =   ggplot2::element_rect(fill = "white", colour = NA),
    panel.border =       ggplot2::element_rect(fill = NA, colour = "grey20"),
    panel.grid.major =   ggplot2::element_blank(),
    panel.grid.minor =   ggplot2::element_blank(),
    panel.ontop    =     FALSE,
    strip.background =   ggplot2::element_rect(fill = "grey85", colour = "grey20"),
    strip.text =         ggplot2::element_text(colour = "grey10", size = ggplot2::rel(0.8)),
    strip.text.x =       ggplot2::element_text(margin = ggplot2::margin(t = half_line, b = half_line)),
    strip.text.y =       ggplot2::element_text(angle = -90, margin = ggplot2::margin(l = half_line, r = half_line)),
    strip.switch.pad.grid = grid::unit(0.1, "cm"),
    strip.switch.pad.wrap = grid::unit(0.1, "cm"),

    plot.background =    ggplot2::element_rect(colour = "white"),
    plot.title =         ggplot2::element_text(
                           size = ggplot2::rel(1.2),
                           hjust = 0, vjust = 1,
                           margin = ggplot2::margin(b = half_line * 1.2)
                         ),
    plot.margin =        ggplot2::margin(half_line, half_line, half_line, half_line),

    complete = TRUE
  )
}

theme_test_recent <- function(base_size = 11, base_family = "") {
  half_line <- base_size / 2

  ggplot2::theme(
    axis.text.x.top =    ggplot2::element_text(margin = ggplot2::margin(b = 0.8 * half_line / 2), vjust = 0),
    axis.text.y.right =  ggplot2::element_text(margin = ggplot2::margin(l = 0.8 * half_line / 2), hjust = 0),
    axis.title.x.top =   ggplot2::element_text(
                           margin = ggplot2::margin(b = half_line),
                           vjust = 0
                         ),
    axis.title.y.right = ggplot2::element_text(
                           angle = -90,
                           margin = ggplot2::margin(l = half_line),
                           vjust = 0
                         ),
    legend.spacing =     grid::unit(0.4, "cm"),
    legend.spacing.x =   NULL,
    legend.spacing.y =   NULL,
    legend.box.margin =  ggplot2::margin(0, 0, 0, 0, "cm"),
    legend.box.background = ggplot2::element_blank(),
    legend.box.spacing = grid::unit(0.4, "cm"),

    panel.spacing =      grid::unit(half_line, "pt"),
    panel.spacing.x =    NULL,
    panel.spacing.y =    NULL,
    strip.placement =    "inside",
    strip.placement.x =  NULL,
    strip.placement.y =  NULL,
    plot.subtitle =      ggplot2::element_text(
                           size = ggplot2::rel(0.9),
                           hjust = 0, vjust = 1,
                           margin = ggplot2::margin(b = half_line * 0.9)
                         ),
    plot.caption =       ggplot2::element_text(
                           size = ggplot2::rel(0.9),
                           hjust = 1, vjust = 1,
                           margin = ggplot2::margin(t = half_line * 0.9)
                         )
    )
}
