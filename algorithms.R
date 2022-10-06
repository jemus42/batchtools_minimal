# Algorithm definition
# First arguments need to be data, job, instance, where instance contains the return value of the problem.
# The return value of this function will be your result later. Choose wisely what to keep/discard!
# Linear model -----------------------------------------------------------
lm_wrapper <- function(data, job, instance, ...) {
  # Fit model
  fit <- lm(y ~ ., data = instance$train, ...)
  pred <- predict(fit, instance$test)

  # Return RMSE
  res <- sqrt(mean((pred - instance$test$y)^2))
  names(res) <- "error"
  res
}

# Random forest
rf_wrapper <- function(data, job, instance, ...) {
  # Fit model
  library(ranger)
  rf <- ranger(y ~ ., data = instance$train, ...)
  pred <- predict(rf, instance$test)$predictions

  # Return RMSE
  res <- sqrt(mean((pred - instance$test$y)^2))
  names(res) <- "error"
  res
}
