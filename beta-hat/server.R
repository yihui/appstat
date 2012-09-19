library(shiny)

N = 30
x = runif(N, 0, 1); y = x + rnorm(N)
xlim = range(x); ylim = range(y)
coef_beta = function(x, y) coef(lm(y ~ x))
b = NULL

shinyServer(function(input, output) {
  
  output$betaPlot = reactivePlot(function() {
    i = input$i
    if (NROW(b) > 100) b <<- NULL
    y = x + rnorm(N)
    par(mfcol = c(1, 2), mar = c(4, 4.3, .1, .1))
    plot(x, y, xlim = xlim, ylim = ylim, pch = 19, col = 'gray',
         ylab = expression(y == beta[0] + beta[1]*x + epsilon))
    b <<- rbind(b, coef_beta(x, y))
    apply(b, 1, function(r) abline(r[1], r[2], col = rgb(0, 0, 0, .2), lty = 2))
    n = nrow(b)
    abline(b[n, 1], b[n, 2])
    abline(0, 1, col = 'red', lwd = 2)
    hist(b[, 2], main = '', xlab = expression(hat(beta)[1]), col = 'lightgray',
         border = 'white')
    abline(v = b[n, 2])
  }, width = 700, height = 400)
  
})
