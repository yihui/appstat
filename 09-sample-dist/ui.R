library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('Sampling distributions'),

  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('This module shows the sampling distribution of a variety of
             statistics such as the mean, variance, median and so on.'),
    selectInput('dist', 'Population distribution:',
                choices = c(
                  'Binomial (n, p)' = '1',
                  'Poisson (lambda)' = '2',
                  'Normal (mu, sigma)' = '3',
                  'Exponential (lambda)' = '4',
                  'Gamma (shape, scale)' = '5'
                )),
    conditionalPanel(
      "input.dist == '1'",
      sliderInput('param11', 'n', min = 1, max = 50, value = 5, step = 1),
      sliderInput('param21', 'p', min = 0, max = 1, value = .3, step = .05)
    ),
    conditionalPanel(
      "input.dist == '2'",
      sliderInput('param12', 'lambda', min = 1, max = 50, value = 5, step = 1)
    ),
    conditionalPanel(
      "input.dist == '3'",
      sliderInput('param13', 'mu', min = -5, max = 5, value = 0),
      sliderInput('param23', 'sigma', min = 0, max = 10, value = 1, step = .1)
    ),
    conditionalPanel(
      "input.dist == '4'",
      sliderInput('param14', 'lambda', min = 0, max = 50, value = 5)
    ),
    conditionalPanel(
      "input.dist == '5'",
      sliderInput('param15', 'shape', min = 0, max = 10, value = 5),
      sliderInput('param25', 'scale', min = 0, max = 10, value = 1)
    ),
    sliderInput('n', 'Sample size', min = 2, max = 100, value = 30, step = 1),
    sliderInput('m', 'Number of simulations', min = 2, max = 500, value = 100, step = 1),
    selectInput('statistic', 'Statistic',
                c('Mean', 'Variance', 'Median', 'Sum', 'Min', 'Max', 'Range'))
  ),

  mainPanel(
    plotOutput('distPlot')
  )
))
