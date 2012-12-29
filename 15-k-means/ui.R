library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('K-Means Clustering'),

  sidebarPanel(
    helpText('This demo shows the steps of k-Means clustering: in each step, we
             either assign points to new cluster centers, or re-calculate the
             centers of all clusters by taking their means.'),
    selectInput('data', 'Data', c(
      'Random Uniform' = 1, 'Random Normal' = 2, 'Mixture of Random Normal' = 3,
      'Old Faithful Geyser' = 4
    )),
    sliderInput('i', 'Step:', min = 0, max = 40, value = 0, step = 1,
                animate = animationOptions(interval = 1000)),
    helpText('Note you can only change the number of clusters before you start
             the animation above. To reset this option, you have to move the
             slider back to 0.'),
    numericInput('centers', 'Number of clusters', min = 1, max = 10, value = 2, step = 1)
  ),

  mainPanel(
    plotOutput('clusterPlot')
  )
))
