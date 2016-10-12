
vdiffrServer <- function(cases) {
  shiny::shinyServer(function(input, output) {
    cases <- shiny::reactiveValues(all = cases)
    cases$active <- shiny::reactive({
      type <- input$type %||% "new"
      filter_cases(cases$all, type)
    })

    output$type_controls <- renderTypeInput(input, cases)
    output$case_controls <- renderCaseInput(input, cases$active)

    output$toggle <- renderDiffer(input, cases$active, widget_toggle)
    output$slide <- renderDiffer(input, cases$active, widget_slide)
    output$diff <- renderDiffer(input, cases$active, widget_diff)

    validateGroupCases(input, cases)
    validateSingleCase(input, cases)

    output$status <- renderStatus(input, cases)
  })
}

renderTypeInput <- function(input, reactive_cases) {
  shiny::renderUI({
    cases <- reactive_cases$all

    types <- unique(map_chr(cases, function(case) class(case)[[1]]))
    types <- ifelse(types == "case_mismatch", "mismatched", "new")

    if (length(types) == 0) {
      return(NULL)
    }
    types <- set_names(types, capitalise(types))

    shiny::selectInput(
      inputId = "type",
      label = "Type:",
      choices = types,
      selected = types[[1]]
    )
  })
}

renderCaseInput <- function(input, active_cases) {
  shiny::renderUI({
    names <- unique(names(active_cases()))

    if (length(names)) {
      shiny::selectInput(
        inputId = "case",
        label = "Case:",
        choices = names,
        selected = names[[1]]
      )
    }
  })
}

renderDiffer <- function(input, active_cases, widget) {
  renderToggle({
    # When renderDiffer() is first called, renderCaseInput() has not
    # been called yet.
    if (is.null(input$case)) {
      return(NULL)
    }

    case <- active_cases()[[input$case]]

    # Somehow dependencies are not resolved well: renderDiffer() gets
    # called before renderCaseInput(). This can result in a
    # temporarily invalid selected case when input changes.
    if (is.null(case)) {
      return(NULL)
    }

    # Inline the SVGs in a src field for now
    pkg_path <- attr(active_cases(), "pkg_path")
    before_path <- file.path(pkg_path, "tests", "testthat", case$path)

    after <- as_inline_svg(read_file(case$testcase))
    if (is_case_new(case)) {
      before <- after
    } else {
      before <- as_inline_svg(read_file(before_path))
    }

    widget(before, after)
  })
}

validateSingleCase <- function(input, reactive_cases) {
  shiny::observe({
    if (input$case_validation_button > 0) {
      cases <- shiny::isolate(reactive_cases$all)
      case <- shiny::isolate(input$case)

      validate_cases(cases[case])

      cases <- cases[-match(case, names(cases))]
      shiny::isolate(reactive_cases$all <- cases)
    }
  })
}

validateGroupCases <- function(input, reactive_cases) {
  shiny::observe({
    if (input$group_validation_button > 0) {
      active_cases <- shiny::isolate(reactive_cases$active())
      cases <- shiny::isolate(reactive_cases$all)

      if (length(cases) > 0) {
        validate_cases(active_cases)

        type <- shiny::isolate(input$type)
        opposite_type <- ifelse(type == "new", "mismatched", "new")
        cases <- filter_cases(cases, opposite_type)

        shiny::isolate(reactive_cases$all <- cases)
      }
    }
  })
}

renderStatus <- function(input, reactive_cases) {
  shiny::renderUI({
    cases <- reactive_cases$all

    if (length(cases) == 0) {
      paragraph <- shiny::p("All done!")
    } else if (input$active_tab == "slide") {
      paragraph <- shiny::p(
        shiny::strong("Slide: "), "Before  |  After"
      )
    } else if (input$active_tab == "toggle") {
      paragraph <- shiny::p(
        shiny::strong("Now Active: "),
        shiny::span(id = "shiny-toggle-status")
      )
    } else {
      paragraph <- shiny::br()
    }

    list(shiny::br(), paragraph)
  })
}
