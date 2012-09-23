library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel('Variability of \\(\\hat{\\beta}_1\\)'),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    tag('script', c(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')),
    helpText('This demo shows you the variablity of the estimates of
             coefficients in linear regressions. The regression model here is
             $$Y_i=\\beta_0+\\beta_1x_i+\\epsilon_i$$ where \\(\\epsilon \\sim
             N(0, I_{n \\times n})\\) and \\(\\beta_0=0, \\beta_1=1\\). We keep
             on simulating \\(\\epsilon\\) from the standard Normal distribution,
             and get different values of \\(\\hat{\\beta}_1\\). The left plot 
             shows the scatter plot of the simulated points: the red line denotes
             the true model, the solid black line represents the current slope,
             and the dashed lines record the historical values of the slope. The
             right histogram shows the distribution of the estimates of the
             slope. You can press the button below to get started:'),
    sliderInput('i', 'Step:', min = 1, max = 100, value = 1, step = 1,
                animate = animationOptions(interval = 500))
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput('betaPlot')
  )
))
