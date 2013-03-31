library(shiny)

shinyServer(function(input, output) {

  output$normalPlot = renderPlot({
    mu = input$mu; s = input$sigma
    p0 = .0000001
    if (input$showq) {
      xval = mu + s * c(1, -1) * qnorm(.5 - input$prob/2)
    } else {
      xval = mu + s * c(1, -1) * qnorm(p0)
      if (input$x1inf) {
        if (!input$x2inf) xval[2] = input$xval2
      } else {
        if (input$x2inf) xval[1] = input$xval1 else xval = input$xval12
      }
    }
    par(mar = c(4, 0, .1, 0))
    x = seq(-5, 5, length = 100)
    plot(x, y <- dnorm(x, mu, s), type = 'n', ylab = 'density', ylim = c(0, .5))
    x0 = seq(xval[1], xval[2], length = 30)
    y0 = c(dnorm(x0, mu, s), rep(0, length(x0)))
    x0 = c(x0, rev(x0))
    polygon(x0, y0, col = 'lightgray', border = NA)
    p = if (input$showq) input$prob else abs(diff(pnorm(xval, mu, s)))
    text(mean(xval), max(y0)/2,
         sprintf('P(%.02f < X < %.02f) = %.04f',
                 if (!input$showq && input$x1inf) -Inf else xval[1],
                 if (!input$showq && input$x2inf) Inf else xval[2], p))
    lines(x, y); box()
    abline(v = mu, col = 'red')
  }, width = 500, height = 400)

})
