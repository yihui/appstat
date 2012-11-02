library(shiny)

calc_ci = function(n, s2) {
  c(c(1, -1) * qnorm(.975) * sd(rnorm(n, 0, sqrt(s2))) / sqrt(n - 1), n, s2)
}
data_ci = NULL

shinyServer(function(input, output) {

  output$ciPlot = reactivePlot(function() {
    n = input$n; s2 = input$var; yvar = input$yvar
    if (n < 2) return()
    if (input$reset) data_ci <<- NULL
    data_ci <<- rbind(data_ci, calc_ci(n, s2))
    y = data_ci[, switch(yvar, n = 3, var = 4)]
    par(mar = c(4, 4, .1, .1))
    plot(rep(0, length(y)), y, xlab = 'CI', ylab = yvar, type = 'n',
         xlim = range(data_ci[, 1:2]))
    segments(data_ci[, 1], y, data_ci[, 2], y, lwd = 2, col = 'darkgray')
    nr = nrow(data_ci)
    segments(data_ci[nr, 1], y[nr], data_ci[nr, 2], y[nr], lwd = 2, col = 'red')
  }, width = 500, height = 500)

})
