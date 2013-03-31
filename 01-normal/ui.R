library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('The Normal Distribution'),

  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('This module demonstrates the Normal distribution
             \\(N(\\mu, \\sigma^2)\\) and the probability \\(P(x_1 < X < x_2)\\)
             (in the shaded area).'),
    sliderInput('mu', '\\(\\mu\\)', min = -3, max = 3, value = 0, step = .1),
    sliderInput('sigma', '\\(\\sigma\\)', min = .8, max = 2, value = 1, step = .1),
    conditionalPanel("!input.showq",
                     helpText('You can set \\(x_1\\) to \\(-\\infty\\), and/or
                              \\(x_2\\) to \\(+\\infty\\) to get one-sided probabilities.'),
                     checkboxInput('x1inf', '\\(x_1=-\\infty\\)'),
                     checkboxInput('x2inf', '\\(x_2=+\\infty\\)')
    ),
    helpText('Or you can set the probability to get the quantiles:'),
    checkboxInput('showq', 'show quantiles'),
    conditionalPanel('input.showq',
                     checkboxInput('oneside', 'one-sided probability'))
  ),

  mainPanel(
    plotOutput('normalPlot', height = 'auto'),
    div(
      conditionalPanel(
        "!input.showq && !(input.x1inf || input.x2inf)",
        sliderInput('xval12', '\\(x_1,x_2\\)', min = -5, max = 5, value = c(0, 5), step = .1)
      ),
      conditionalPanel(
        "!input.showq && input.x1inf && !input.x2inf",
        sliderInput('xval2', '\\(x_2\\)', min = -5, max = 5, value = 0, step = .1)
      ),
      conditionalPanel(
        "!input.showq && !input.x1inf && input.x2inf",
        sliderInput('xval1', '\\(x_1\\)', min = -5, max = 5, value = 0, step = .1)
      ),
      conditionalPanel(
        "input.showq",
        sliderInput('prob', 'Probability', min = 0, max = 1, value = 0.5, step = .01)
      ),
      style = 'width: 500px'
    )
  )
))
