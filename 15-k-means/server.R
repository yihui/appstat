library(shiny)

shinyServer(function(input, output) {

  centers = NULL # number of cluster centers
  ocluster = NULL # clusters of previous step
  converged = FALSE  # convergence

  mix_norm = reactive({
    n = input$centers
    do.call(rbind, lapply(1:n, function(i) {
      cbind(X1 = rnorm(50, runif(1, -5, 5)), X2 = rnorm(50, runif(1, -5, 5)))
    }))
  })
  data_gen = reactive({
    switch(as.integer(input$data),
           cbind(X1 = runif(50), X2 = runif(50)),
           cbind(X1 = rnorm(50), X2 = rnorm(50)),
           mix_norm(), as.matrix(faithful))
  })
  output$clusterPlot = renderPlot({
    i = input$i; x = data_gen()
    if (i == 0) {
      # initialize
      centers <<- input$centers
      ocluster <<- sample(centers, nrow(x), replace = TRUE)
      centers <<- x[sample(nrow(x), centers), ]
      converged <<- FALSE
    }
    numcent = nrow(centers)
    pch = col = 1:numcent
    dst = matrix(nrow = nrow(x), ncol = numcent)
    par(mar = c(4, 4, 2, .1))
    if (i == 0 || (i %% 2 == 1) || converged) {
      plot(x, pch = pch[ocluster], col = col[ocluster], panel.first = grid(),
           main = ifelse(converged, 'Converged!', 'Move centers!'))
      points(centers, pch = pch[1:numcent], cex = 3, lwd = 2, col = col[1:numcent])
    } else {
      for (j in 1:numcent) {
        dst[, j] = sqrt(apply((t(t(x) - unlist(centers[j, ])))^2, 1, sum))
      }
      ncluster = apply(dst, 1, which.min)
      plot(x, type = "n", main = 'Find cluster?')
      grid()
      ocenters = centers
      for (j in 1:numcent) {
        xx = subset(x, ncluster == j)
        polygon(xx[chull(xx), ], density = 10, col = col[j],
                lty = 2)
        points(xx, pch = pch[j], col = col[j])
        centers[j, ] <<- apply(xx, 2, mean)
      }
      points(ocenters, cex = 3, col = col[1:numcent], pch = pch[1:numcent], lwd = 2)
      if (all(ncluster == ocluster)) converged <<- TRUE
      ocluster <<- ncluster
    }
  }, width = 600, height = 500)

})
