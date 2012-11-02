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
                  'Binomial (n = param1, p = param2)',
                  'Poisson (lambda = param1)',
                  'Normal (mu = param1, sigma = param2)',
                  'Exponential (lambda = param1)',
                  'Gamma (shape = param1, scale = param2)'
                )),
    sliderInput('param1', 'Parameter 1', min = 0, max = 10, value = 5, step = .1),
    sliderInput('param2', 'Parameter 2', min = 0, max = 10, value = .3, step = .1),
    sliderInput('n', 'Sample size', min = 2, max = 100, value = 30, step = 1),
    sliderInput('m', 'Number of simulations', min = 2, max = 500, value = 100, step = 1),
    selectInput('statistic', 'Statistic',
                c('Mean', 'Variance', 'Median', 'Sum', 'Min', 'Max', 'Range'))
  ),

  mainPanel(
    plotOutput('distPlot')
  )
))
