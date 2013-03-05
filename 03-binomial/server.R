library(shiny)

rx = NULL  # stores the random sample

shinyServer(function(input, output) {

  output$binomPlot = reactivePlot({
    n = input$n; p = input$p; m = input$m
    par(mar = c(4, 4, 2, .1))
    x = 0:n; y = dbinom(x, n, p)
    plot(x, y, type = 'h', ylab = 'probability', lwd = 3)
    if (input$m != 0) {
      if (length(rx) > 100) rx <<- NULL
      rx <<- c(rx, newx <- rbinom(1, input$n, input$p))
      rx = factor(rx, levels = x)
      tb = table(rx)/100
      rect(x-.2, 0, x+.2, tb, col = '#00000080', border = NA)
      rug(sample(n, newx), side = 3, lwd = 2, col = 'red')
      axis(side = 3, at = x, labels = FALSE); title(sprintf('X = %d', newx), cex.main = 1)
      if (input$m == 100) rx <<- NULL
    }
  }, width = 600, height = 500)

})
