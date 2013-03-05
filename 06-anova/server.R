library(shiny)

shinyServer(function(input, output) {

  # Make three independent, repeatable copies of rnorm so that the underlying
  # random values don't change
  rnorm1 = repeatable(rnorm)
  rnorm2 = repeatable(rnorm)
  rnorm3 = repeatable(rnorm)

  gen_data = reactive({
    n = input$n; mu1 = input$mu1; mu2 = input$mu2; mu3 = input$mu3; s = input$sigma
    data.frame(y = c(rnorm1(n, mu1, s), rnorm2(n, mu2, s), rnorm3(n, mu3, s)),
               group = factor(rep(sprintf('mu%s', 1:3), each = n), levels = sprintf('mu%s', 3:1)))
  })

  output$aovPlot = reactivePlot({
    d = gen_data()
    par(mar = c(4, 4, .1, .1), mgp = c(2.8, 1, 0), las = 1)
    plot(y ~ group, data = d, border = 'gray', horizontal = TRUE)
    points(group ~ y, data = d, col = rgb(0, 0, 0, .8))
    points(c(input$mu1, input$mu2, input$mu3), 3:1, pch = '|', cex = 2, col = 'red')
  }, width = 600, height = 300)

  output$aovSummary = reactivePrint({
    summary(aov(y ~ group, data = gen_data()))
  })

})
