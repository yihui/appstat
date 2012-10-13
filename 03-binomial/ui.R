library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('The Binomial Distribution'),

  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('This module demonstrates the Binomial distribution
             $$P(X = k)={n \\choose k}p^{k}(1-p)^{n-k}$$
             You can specify N and p, and simulate from the distribution
             for 100 times.'),
    sliderInput('n', '\\(N\\)', min = 1, max = 30, value = 10, step = 1),
    sliderInput('p', '\\(p\\)', min = 0, max = 1, value = .2, step = .1),
    sliderInput('m', 'Simulate (press the button to begin):', min = 0, max = 100,
                value = 0, step = 1, animate = animationOptions(interval = 500)),
    helpText('When simulating from the Binomial distribution, see all the little
             bars in the top. Each bar has the probability p to be selected
             (when it is selected, it is marked by a red bar below).')
  ),

  mainPanel(
    plotOutput('binomPlot', height = 'auto')
  )
))
