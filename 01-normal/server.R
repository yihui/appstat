library(shiny)

shinyServer(function(input, output) {

  output$normalPlot = reactivePlot(function() {
    mu = input$mu; s = input$sigma; xval = input$xval
    par(mar = c(4, 4, .1, .1))
    x = seq(qnorm(.001, mu, s), qnorm(.999, mu, s), length = 100)
    plot(x, y <- dnorm(x, mu, s), type = 'n', ylab = 'density', ylim = c(0, .5))
    if (max(x) > xval) {
      x0 = seq(xval, max(x), length = 30)
      y0 = c(dnorm(x0, mu, s), rep(0, length(x0)))
      x0 = c(x0, rev(x0))
      polygon(x0, y0, col = 'lightgray', border = NA)
      p = pnorm(xval, mu, s, lower.tail = FALSE)
    } else p = 0
    legend('topright', sprintf('P(X > %s) = %.04f', xval, p), fill = 'lightgray', bty = 'n')
    lines(x, y); box()
  }, width = 500, height = 400)

})
