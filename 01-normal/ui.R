library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('The Normal Distribution'),

  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('This module demonstrates the Normal distribution
             \\(N(\\mu, \\sigma^2)\\) and the probability \\(P(X > x)\\)
             (in the shaded area).'),
    sliderInput('mu', '\\(\\mu\\)', min = -3, max = 3, value = 0, step = .1),
    sliderInput('xval', '\\(x\\)', min = -5, max = 5, value = 0, step = .05),
    sliderInput('sigma', '\\(\\sigma\\)', min = .8, max = 2, value = 1, step = .05)
  ),

  mainPanel(
    plotOutput('normalPlot', height = 'auto')
  )
))
