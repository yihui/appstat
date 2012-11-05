library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('Bootstrap (resampling)'),

  sidebarPanel(
    helpText('This module shows bootstrapping by (re)sampling data with
             replacement. The new (resampled) data points are denoted by red
             circles in the top histogram, and the distribution of the mean of
             the resampled data is showed in the bottom histogram. Note the red
             circles are semi-transparent; darker red indicates a point was
             sampled for more times. The vertical line denotes the current mean.'),
    selectInput('data', 'Data', c('Random Normal' = 1, 'Random Uniform' = 2,
                                  'Geyser eruptions' = 3, 'Geyser waiting' = 4)),
    sliderInput('i', 'Step', min = 0, max = 100, value = 0, step = 1,
                animate = animationOptions(interval = 1000))
  ),

  mainPanel(
    plotOutput('bootPlot')
  )
))
