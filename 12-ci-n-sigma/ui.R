library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel('Confidence intervals with different n and \\(\\sigma\\)'),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('This module shows how the confidence intervals change with
             different sample sizes and variances. The data is from
             \\(N(0, \\sigma^2)\\)'),
    sliderInput('n', 'Sample size:', min = 0, max = 100, value = 30, step = 5,
                animate = animationOptions(interval = 500)),
    numericInput('var', '\\(\\sigma^2\\)', min = 0, max = 10, value = 1, step = 1),
    selectInput('yvar', 'Plot CI vs:', c('Sample size' = 'n', 'Variance' = 'var')),
    checkboxInput('reset', 'Clear history')
  ),
  
  mainPanel(
    plotOutput('ciPlot')
  )
))
