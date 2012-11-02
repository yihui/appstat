

library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('Diagnostics of outliers in regression'),

  sidebarPanel(
    sliderInput('i', 'Sample index:', min = 1, max = 30, value = 10),
    numericInput('xval', 'Change value of x:', min = -10, max = 20, value = 1, step = .2),
    numericInput('yval', 'Change value of y:', min = -10, max = 20, value = 1, step = .2)
  ),

  mainPanel(
    plotOutput('diagPlot')
  )
))
