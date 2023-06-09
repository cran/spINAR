llpinar_nb <- list(
  function(par, dat) {
    n <- length(dat)
    alpha <- par[1]
    r <- round(par[2])
    prob <- par[3]
    value <- 0
    for (t in 2:n) {
      cp <-
        sum(dbinom(
          x = 0:min(dat[t], dat[t - 1]),
          size = dat[t - 1],
          prob = alpha
        )
        * dnbinom(dat[t] - (0:min(dat[t], dat[t-1])), r, prob))
      value <- value - log(cp)
    }
    value
  },
  function(par, dat) {
    n <- length(dat)
    alpha1 <- par[1]
    alpha2 <- par[2]
    r <- round(par[3])
    prob <- par[4]
    value <- 0
    for (t in 3:n) {
      cp <- 0
      for (i in c(0:min(dat[t], dat[t - 1]))) {
        cp <-
          cp + dbinom(i, dat[t - 1], alpha1) * sum(dbinom((0:min(
            dat[t] - i, dat[t - 2]
          )), dat[t - 2], alpha2) * dnbinom(dat[t] - i - (0:min(dat[t] - i, dat[t-2])), r, prob))
      }
      value <- value - log(cp)
    }
    value
  })
