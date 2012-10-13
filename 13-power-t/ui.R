library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel('Power of Two-sample t-test'),
  
  sidebarPanel(
    tags$head(
      tags$script(src = 'https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML', type = 'text/javascript')
    ),
    helpText('The model for this demo is $$Y_{ij}=\\mu_{i}+\\epsilon_{ij}$$
             where \\(\\mu\\) is the group mean, and \\(\\epsilon\\) is the
             random error term. There are two groups \\(i=1,2\\) and n samples
             \\(j=1,2,\\cdots,n\\) in each group. The null hypothesis is
             $$H_0: \\mu_1=\\mu_2$$ We can use t-test here. Let
             \\(\\delta=\\mu_1-\\mu_2\\) and suppose \\(\\epsilon\\sim N(0, \\sigma^2)\\);
             given the confidence level \\(1-\\alpha\\), we know the power of the test.'),
    sliderInput('n', 'Sample size (n):', min = 2, max = 100, value = 30),
    sliderInput('delta', '\\(\\delta\\)', min = 0, max = 10, value = 1, step = .1),
    sliderInput('alpha', '\\(\\alpha\\)', min = 0, max = 1, value = .05, step = .01),
    sliderInput('sd', '\\(\\sigma\\)', min = 0, max = 10, value = 1, step = .1)
  ),
  
  mainPanel(
    plotOutput('pwrPlot')
  )
))
