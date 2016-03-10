
as_inline_svg <- function(svg) {
  paste0("data:image/svg+xml;utf8,", svg)
}

as_svg <- function(p) {
  svg <- svglite::svgstring()
  tryCatch(
    print_plot(p),
    finally = grDevices::dev.off()
  )
  svg()
}

print_plot <- function(p) {
  UseMethod("print_plot")
}

print_plot.ggplot <- function(p) {
  print(p)
}

print_plot.function <- function(p) {
  p()
}

read_svg <- function(file) {
  structure(read_file(file), class = "svg")
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
