# Run batchtools with given problems and algorithms
library(batchtools)
library(ggplot2)

# Pick a seed and make it a good one.
set.seed(42)

# Registry ----------------------------------------------------------------
# Create a registry named "example" in registries/example, relative to current working directory
reg_name <- "example"
if (!file.exists("registries")) dir.create("registries")
reg_dir <- file.path("registries", reg_name)
# Delete registry to recreate it -- !! handle with care, don't delete your finished jobs pls !!
unlink(reg_dir, recursive = TRUE)

# Create the registry at specified directory - this holds all the important metadata __and results__
makeExperimentRegistry(file.dir = reg_dir, seed = 42)

# Problems -----------------------------------------------------------
source("problems.R")
# Add the problems to the registry
# you can pick a different `name` but `fun` has to be the bare name of the function
addProblem(name = "sim_norm", fun = sim_norm, seed = 43)
addProblem(name = "sim_binom", fun = sim_binom, seed = 44)

# Algorithms -----------------------------------------------------------
source("algorithms.R")
addAlgorithm(name = "lm", fun = lm_wrapper)
addAlgorithm(name = "rf", fun = rf_wrapper)

# Experiments -----------------------------------------------------------
# Define parameter grid for the problems and algorithms.
# Don't be too gready, combinatorics is a cruel mistress!
prob_design <- list(
  sim_norm = expand.grid(
    n = 100,
    p = c(10, 50, 100),
    beta = 0.5
  ),
  sim_binom = expand.grid(
    n = 100,
    p = c(10, 50, 100),
    beta = 0.5
  )
)

algo_design <- list(
  lm = expand.grid(),
  rf = expand.grid(num.trees = c(5, 10, 100))
)

# `repls` defines how often the algorithm will be fit on each problems
addExperiments(prob_design, algo_design, repls = 10)

# Getting an overview of your jobs
summarizeExperiments()

# Test jobs -----------------------------------------------------------
# Result of this job will not be saved, this is just for testing
testJob(id = 1)

# Submit -----------------------------------------------------------
# This is only applicable to the BIPS cluster
if (grepl("node\\d{2}|bipscluster", system("hostname", intern = TRUE))) {
  ids <- findNotStarted()
  ids[, chunk := chunk(job.id, chunk.size = 50)]
  submitJobs(ids = ids, # walltime in seconds, 10 days max, memory in MB
             resources = list(name = reg_name, chunks.as.arrayjobs = TRUE,
                              ncpus = 1, memory = 6000, walltime = 10*24*3600,
                              max.concurrent.jobs = 40))
} else {
  # This will run otherwise. By default all jobs will be submitted, use with care.
  submitJobs()
}
waitForJobs()

# Quick primer on finding jobs
if (FALSE) {
  # List all the jobs you defined - this just shows their ids
  findJobs()

  # Full overview of the jobs
  getJobTable()

  # Filter experiments for some condition, e.g. this with p == 100
  selected_jobs <- findExperiments(prob.pars = p == 100)
  # This allows you to selectively start/restart certain jobs fairly simply
  submitJobs(selected_jobs)
}
