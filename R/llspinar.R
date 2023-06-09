llspinar <- list(
  function(par, dat) {
    n <- length(dat)
    alpha <- par[1]
    pmf <- par[-1]
    pmf <- c(1 - sum(pmf), pmf)
    value <- 0
    for (t in 2:n) {
      cp <-
        sum(dbinom(
          x = 0:min(dat[t], dat[t - 1]),
          size = dat[t - 1],
          prob = alpha
        )
        * pmf[dat[t] +  1 - (0:min(dat[t], dat[t-1]))])
      value <- value - log(cp)
    }
    value
  },
  function(par, dat) {
    n <- length(dat)
    alpha1 <- par[1]
    alpha2 <- par[2]
    pmf <- par[-(1:2)]
    pmf <- c(1 - sum(pmf), pmf)
    value <- 0
    for (t in 3:n) {
      cp <- 0
      for (i in c(0:min(dat[t], dat[t - 1]))) {
        cp <-
          cp + dbinom(i, dat[t - 1], alpha1) * sum(dbinom((0:min(
            dat[t] - i, dat[t - 2]
          )), dat[t - 2], alpha2) * pmf[dat[t] + 1 - i - (0:min(dat[t] - i, dat[t-2]))])
      }
      value <- value - log(cp)
    }
    value
  })
