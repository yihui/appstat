library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('The Response Surface'),

  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    includeHTML('description'),
    sliderInput('b0', '\\(\\beta_0\\)', min = -3, max = 3, value = 0, step = .1),
    sliderInput('b1', '\\(\\beta_1\\)', min = -3, max = 3, value = 1, step = .1),
    sliderInput('b2', '\\(\\beta_2\\)', min = -3, max = 3, value = -1, step = .1),
    sliderInput('b3', '\\(\\beta_3\\)', min = -3, max = 3, value = 0, step = .1),
    sliderInput('b4', '\\(\\beta_4\\)', min = -3, max = 3, value = 0, step = .1),
    sliderInput('b5', '\\(\\beta_5\\)', min = -3, max = 3, value = 0, step = .1),
    sliderInput('sigma', '\\(\\sigma\\)', min = 0, max = 5, value = 1, step = .1),
    sliderInput('theta', '\\(\\theta\\) (azimuthal direction)', min = 0, max = 360, value = 0,
                animate = animationOptions(250, loop = TRUE)),
    sliderInput('phi', '\\(\\phi\\) (colatitude direction)', min = 0, max = 360, value = 15,
                animate = animationOptions(250, loop = TRUE))
  ),

  mainPanel(
    plotOutput('surfacePlot', height = 'auto')
  )
))
