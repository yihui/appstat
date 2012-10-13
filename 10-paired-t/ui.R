library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel('Independent Two-sample t-test vs Paired t-test'),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('The model for this demo is $$Y_{ij}=\\mu_{i}+\\gamma_{j}+\\epsilon_{ij}$$
             where \\(\\mu\\) is the fixed effect (group mean), \\(\\gamma\\)
             is the random effect for individuals, and \\(\\epsilon\\) is the
             random error term. There are two groups \\(i=1,2\\) and n individuals
             \\(j=1,2,\\cdots,n\\). The goal here is to test the hypothesis
             $$H_0: \\mu_1=\\mu_2$$ We can use t-test here and obtain a confidence
             interval (CI) for \\(\\mu_1-\\mu_2\\). As n increases, the CI will
             be narrower; in general, the paired t-test should give a narrower CI
             than the independent two-sample t-test.'),
    sliderInput('n', 'Sample size:', min = 10, max = 100, value = 30),
    numericInput('var', 'Variance of random effect:', min = 0, max = 10, value = 1, step = .1)
  ),
  
  mainPanel(
    plotOutput('ciPlot')
  )
))
