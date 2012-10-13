library(shiny)

N = 30 # sample size
x = sort(runif(N, 0, 10)); y = x + rnorm(N)
s = rep(1, N)

shinyServer(function(input, output) {
  
  output$diagPlot = reactivePlot(function() {
    i = input$i; xval = input$xval; yval = input$yval
    s[i] = 19  # make the i-th point solid
    par(mfrow = c(2, 2), mar = c(4, 4, .1, .1))
    # scatter plot with fitted lines
    plot(x, y, xlim = range(c(x, xval)), ylim = range(c(y, yval)))
    grid()
    points(x[i], y[i], pch = 19, cex = 1.5)
    points(xval, yval, pch = 19, col = 'red', cex = 1.5)
    x2 = x; y2 = y; x2[i] = xval; y2[i] = yval
    fit = lm(y ~ x); fit2 = lm(y2 ~ x2)
    abline(fit); abline(fit2, col = 'red')
    
    # residuals
    r1 = residuals(fit); r2 = residuals(fit2)
    rs1 = drop(scale(r1)); rs2 = drop(scale(r2))
    
    # Cook's distance
    c1 = cooks.distance(fit); c2 = cooks.distance(fit2)
    plot(0, xlim = range(1:N), ylim = range(c(c1, c2)), type = 'n', ylab = "Cook's distance")
    grid()
    points(1:N-.2, c1, type = 'h'); points(1:N + .2, c2, col = 'red', type = 'h')
    points(1:N-.2, c1, cex = abs(rs1), pch = s); points(1:N+.2, c2, cex = abs(rs2), col='red', pch = s)
    
    # dffits
    d1 = dffits(fit); d2 = dffits(fit2)
    plot(0, xlim = range(1:N), ylim = range(c(d1, d2)), type = 'n', ylab = 'DFFITS')
    grid()
    points(d1, pch = s); points(d2, col = 'red', pch = s)
    
    # hat values
    h1 = hatvalues(fit); h2 = hatvalues(fit2)
    plot(0, xlim = range(1:N), ylim = range(c(h1, h2)), type = 'n', ylab = 'Hat values')
    grid()
    points(h1, pch = s); points(h2, col = 'red', pch = s)

  }, width = 700, height = 600)
  
})
