library(shiny)

shinyServer(function(input, output) {

  gen_data = reactive(function() {
    n = input$n; mu1 = input$mu1; mu2 = input$mu2; mu3 = input$mu3; s = input$sigma
    data.frame(y = c(rnorm(n, mu1, s), rnorm(n, mu2, s), rnorm(n, mu3, s)),
               group = rep(sprintf('mu%s', 1:3), each = n))
  })

  output$aovPlot = reactivePlot(function() {
    d = gen_data()
    par(mar = c(4, 4, .1, .1), mgp = c(2.8, 1, 0), las = 1)
    plot(y ~ group, data = d, border = 'gray', horizontal = TRUE)
    points(group ~ y, data = d, col = rgb(0, 0, 0, .8))
    points(c(input$mu1, input$mu2, input$mu3), 1:3, pch = '|', cex = 2, col = 'red')
  }, width = 600, height = 300)

  output$aovSummary = reactivePrint(function() {
    summary(aov(y ~ group, data = gen_data()))
  })

})
