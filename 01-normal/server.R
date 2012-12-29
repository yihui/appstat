library(shiny)

shinyServer(function(input, output) {

  output$normalPlot = reactivePlot(function() {
    mu = input$mu; s = input$sigma; xval = input$xval
    if (input$x1inf) xval[1] = qnorm(.0000001, mu, s)
    if (input$x2inf) xval[2] = qnorm(.9999999, mu, s)
    par(mar = c(4, 0, .1, 0))
    x = seq(-5, 5, length = 100)
    plot(x, y <- dnorm(x, mu, s), type = 'n', ylab = 'density', ylim = c(0, .5))
    x0 = seq(xval[1], xval[2], length = 30)
    y0 = c(dnorm(x0, mu, s), rep(0, length(x0)))
    x0 = c(x0, rev(x0))
    polygon(x0, y0, col = 'lightgray', border = NA)
    p = abs(diff(pnorm(xval, mu, s)))
    text(mean(xval), max(y0)/2,
         sprintf('P(%s < X < %s) = %.04f', if (input$x1inf) -Inf else xval[1],
                 if (input$x2inf) Inf else xval[2], p))
    lines(x, y); box()
    abline(v = mu, col = 'red')
  }, width = 500, height = 400)

})
