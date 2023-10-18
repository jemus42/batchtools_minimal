#! /usr/bin/env Rscript
# monitor current status
library(batchtools)
reg_dir <- "registries/example"
# Load the registry in non-writable mode to avoid possibly messing something up
# If the registry changes in some way while jobs are still being submitted batchtools will stop, so beware
loadRegistry(reg_dir, writeable = FALSE)

# Overall status --------------------------------------------------------------------------------------------------
getStatus()
cat("\n")

# Running --------------------------------------------------------------------------------------------------------
cli::cli_h1("Running")

# Group by possible simulation params, e.g. n, p - adjust as needed
tbl_running <- unwrap(getJobTable(findRunning()))
if (nrow(tbl_running) > 0) {
  # tbl_running[, c("job.id", "time.running"]
  tbl_running[, .(count = .N), by = .(n, p, beta, num.trees)]
}

# Done -------------------------------------------------------------------------------------------------------------
cli::cli_h1("Done")
tbl_done <- unwrap(getJobTable(findDone()))
if (nrow(tbl_done) > 0) {
  tbl_done[, .(count = .N), by = .(n, p, beta, num.trees)]
}
cat("\n")

# Expired -----------
cli::cli_h1("Expired")
tbl_expired <- unwrap(getJobTable(findExpired()))
if (nrow(tbl_expired) > 0) {
  tbl_expired <- tbl_expired[, c("job.id", "time.running")]
  tbl_expired[, .(count = .N), by = .(n, p, beta, num.trees)]
}
cat("\n")

# Error'd --------------------------------------------------------------------------------------------------------
cli::cli_h1("Errors")
getErrorMessages(findErrors())
