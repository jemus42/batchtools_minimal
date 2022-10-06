# Problem deifnitions
# Return value is passed to algorithms as `instance`

# Simulation with normal distributed data -----------------------------------------------------------
sim_norm <- function(data, job, n, p, beta) {
  # Training data
  x <- replicate(p, rnorm(n))
  y <- x %*% rep(beta, p) + rnorm(n)
  train <- data.frame(y = y, x = x)

  # Testing data
  x <- replicate(p, rnorm(n))
  y <- x %*% rep(beta, p) + rnorm(n)
  test <- data.frame(y = y, x = x)

  # Return training and test data
  list(train = train, test = test)
}

# Simulation with binomial distributed data -----------------------------------------------------------
sim_binom <- function(data, job, n, p, beta) {
  # Training data
  x <- replicate(p, rbinom(n, 1, prob = 0.5))
  y <- x %*% rep(beta, p) + rnorm(n)
  train <- data.frame(y = y, x = x)

  # Testing data
  x <- replicate(p, rbinom(n, 1, prob = 0.5))
  y <- x %*% rep(beta, p) + rnorm(n)
  test <- data.frame(y = y, x = x)

  # Return training and test data
  list(train = train, test = test)
}
