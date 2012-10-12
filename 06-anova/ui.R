library(shiny)

shinyUI(pageWithSidebar(

  headerPanel('Analysis of Variance'),

  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('This module demonstrates ANOVA for this model
             $$Y_{ij}=\\mu_{i}+\\epsilon_{ij}$$ where \\(\\mu\\) is the group
             mean, and \\(\\epsilon\\) is the random error term
             \\(\\sim N(0, \\sigma^2)\\). There are three groups \\(i=1,2,3\\) and n
             individuals \\(j=1,2,\\cdots,n\\) in each group. The goal here is
             to test the hypothesis \\(H_0: \\mu_1=\\mu_2=\\mu_3\\) We can use
             F-test here: \\(F=MS_{between}/MS_{within}\\).'),
    sliderInput('mu1', '\\(\\mu_1\\)', min = -5, max = 5, value = 0, step = .1),
    sliderInput('mu2', '\\(\\mu_2\\)', min = -5, max = 5, value = 0, step = .1),
    sliderInput('mu3', '\\(\\mu_3\\)', min = -5, max = 5, value = 0, step = .1),
    sliderInput('sigma', '\\(\\sigma\\)', min = 0, max = 10, value = 1, step = .1),
    sliderInput('n', '\\(n\\)', min = 2, max = 100, value = 30, step = 1)
  ),

  mainPanel(
    helpText('The red bars denote group means.'),
    plotOutput('aovPlot', height = 'auto'),
    h3('ANOVA Table'),
    verbatimTextOutput('aovSummary')
  )
))
