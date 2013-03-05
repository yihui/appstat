library(shiny)

dist_check = function(dist, param1, param2) {
  switch(
    dist,
    binomial = {
      if (param1 <= 0) stop('size must be greater than 0')
      if (param2 < 0 || param2 > 1) stop('probability must be between 0 and 1')
    },
    poisson = {
      if (param1 < 0) stop('lambda must be greater than 0')
    },
    normal = {
      if (param2 < 0) stop('standard deviation must be greater than 0')
    },
    exponential = {
      if (param1 <= 0) stop('rate must be greater than 0')
    },
    gamma = {
      if (param1 <= 0) stop('shape must be greater than 0')
      if (param2 <= 0) stop('scale must be greater than 0')
    }
  )
}

gen_rand = function(dist, param1, param2, n) {
  dist_check(dist, param1, param2)
  switch(
    dist,
    binomial = rbinom(n, size = param1, prob = param2),
    poisson = rpois(n, param1),
    normal = rnorm(n, param1, param2),
    exponential = rexp(n, param1),
    gamma = rgamma(n, shape = param1, scale = param2)
  )
}

gen_dens = function(dist, param1, param2) {
  dist_check(dist, param1, param2)
  res = switch(
    dist,
    binomial = list(x = 0:param1, y = dbinom(0:param1, size = param1, prob = param2), type = 'h'),
    poisson = {
      x = 0:qpois(.99, param1)
      list(x = x, y = dpois(x, param1), type = 'h')
    },
    normal = {
      x0 = qnorm(.01, param1, param2); x1 = qnorm(.99, param1, param2)
      x = seq(x0, x1, length = 50)
      list(x = x, y = dnorm(x, param1, param2), type = 'l')
    },
    exponential = {
      x = seq(0, qexp(.99, param1), length = 50)
      list(x = x, y = dexp(x, param1), type = 'l')
    },
    gamma = {
      x = seq(0, qgamma(.99, param1, param2), length = 50)
      list(x = x, y = dgamma(x, shape = param1, scale = param2), type = 'l')
    }
  )
  res$xlab = 'population distribution'; res$ylab = 'density'
  res
}

gen_stat = function(dist, param1, param2, n, statistic, m) {
  FUN = switch(
    tolower(statistic),
    mean = mean,
    variance = var,
    median = median,
    sum = sum,
    min = min,
    max = max,
    range = function(x) diff(range(x))
  )
  replicate(m, FUN(gen_rand(dist, param1, param2, n)))
}

shinyServer(function(input, output) {

  output$distPlot = renderPlot({
    n = input$n; m = input$m
    param1 = eval(parse(text = paste0('input$param1', input$dist)))
    param2 = eval(parse(text = paste0('input$param2', input$dist)))
    dist = switch(input$dist, `1` = 'binomial', `2` = 'poisson', `3` = 'normal',
                  `4` = 'exponential', `5` = 'gamma')
    statistic = input$statistic
    par(mfrow = c(1, 2), mar = c(4, 4, .1, .1))
    # population distribution
    do.call(plot, gen_dens(dist, param1, param2))
    # sampling distribution
    xs = gen_stat(dist, param1, param2, n, statistic, m)
    hist(xs, prob = TRUE, xlab = paste('sampling distribution of', statistic), main = '',
         col = 'lightgray', border = 'white')
    lines(density(xs), col = 'red')
    rug(xs)
  }, width = 700, height = 400)

})
