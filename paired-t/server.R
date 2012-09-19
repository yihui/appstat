library(shiny)

t_ci = function(x, y, paired = FALSE) {
  t.test(x, y, paired = paired)$conf.int
}
shinyServer(function(input, output) {
  
  output$ciPlot = reactivePlot(function() {
    n = input$n; s = sqrt(input$var)
    ci1 = matrix(nrow = n - 1, ncol = 2)
    ci2 = matrix(nrow = n - 1, ncol = 2)
    err = function(n) rnorm(n, sd = s)
    for (i in (2:n) -1) {
      x = rnorm(i + 1); y = rnorm(i + 1); e = err(i + 1)
      ci1[i, ] = t_ci(x + e, y + e, paired = FALSE)
      ci2[i, ] = t_ci(x + e, y + e, paired = TRUE)
    }
    x = rnorm(n); y = rnorm(n); e = err(n)
    ci1n = t_ci(x + e, y + e, paired = FALSE)
    ci2n = t_ci(x + e, y + e, paired = TRUE)
    par(mar = c(4, 4, .1, .1))
    plot(0, xlim = range(2:n), ylim = range(c(ci1, ci1n, ci2, ci2n)), type = 'n',
         xlab = 'sample size', ylab = expression('95% CI of'~mu[1]-mu[2]))
    grid()
    arrows(2:n-.1, ci1[, 1], 2:n-.1, ci1[, 2], angle = 90, length = .05, code = 3)
    arrows(2:n+.1, ci2[, 1], 2:n+.1, ci2[, 2], col = 'red', angle = 90, length = .05, code = 3)
    legend('topright', c('paired', 'independent'), col = c('red', 'black'), pch = 19)
  }, width = 700, height = 500)
  
})
