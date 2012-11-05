library(shiny)

shinyServer(function(input, output) {

  s = NULL
  data_gen = reactive(function() {
    s <<- NULL
    switch(as.integer(input$data), rnorm(50), runif(50), faithful[, 1], faithful[, 2])
  })

  output$bootPlot = reactivePlot(function() {
    i = input$i; x = data_gen()
    if (i == 0) {
      plot.new(); text(.5, .5, 'Press the button to get started')
      s <<- NULL; return()
    } else if (i <= length(s)) {
      plot.new(); text(.5, .5, 'You cannot move the slider back')
      return()
    }
    for (j in seq_len(i - length(s))) {
      idx = sample(seq_along(x), replace = TRUE)
      s <<- c(s, mean(x[idx]))
    }
    par(mfrow = c(2, 1), mar = c(4, 4, 2, .1))
    hist(x, 30, main = 'Original data', col = 'gray', border = 'white')
    rug(x)
    points(x[idx], rep(par('usr')[3], length(x)), col = rgb(1, 0, 0, .5),
           pch = 21, cex = 2, lwd = 2, xpd = NA)
    hist(s, 30, main = 'Resample mean', col = 'gray', border = 'white')
    abline(v = s[i])
  }, width = 600, height = 550)

})
