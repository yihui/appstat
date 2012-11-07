library(shiny)

x0 = y0 = -5; x1 = y1 = 5
xs = seq(x0, x1, length = 10)
ys = seq(y0, y1, length = 10)
fxy = function(x, y, b) {
  b[1] + b[2] * x + b[3] * y + b[4] * x * y + b[5] * x^2 + b[6] * y^2
}

shinyServer(function(input, output) {

  gen_data = reactive(function() {
    x = runif(30, x0, x1); y = runif(length(x), y0, y1)
    z = fxy(x, y, c(input$b0, input$b1, input$b2, input$b3, input$b4, input$b5)) +
      rnorm(length(x), sd = input$sigma)
    list(x = x, y = y, z = z)
  })

  gen_surface = reactive(function() {
    z = outer(xs, ys, function(x, y) {
      fxy(x, y, c(input$b0, input$b1, input$b2, input$b3, input$b4, input$b5))
    })
    list(x = xs, y = ys, z = z)
  })

  output$surfacePlot = reactivePlot(function() {
    s = gen_surface()
    par(mar = rep(0, 4))
    pmat = persp(s$x, s$y, s$z, theta = input$theta, phi = input$phi,
                 xlab = 'X1', ylab = 'X2', zlab = 'Y')
    d = gen_data()
    points(trans3d(d$x, d$y, d$z, pmat), col = 'red', pch = 19)
  }, width = 500, height = 500)

})
