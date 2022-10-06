# batchtools_minimal

A minimal example of a [`batchtools`](https://mllg.github.io/batchtools/articles/batchtools.html) setup for local usage.

This is a demonstration project to help people get started with a simple `batchtools` setup that does not rely on
any HPC infrastructure and just runs jobs on your local machine, but in a more structured way that via e.g. `doParallel` and friends.

Please only use this is a point of entry or for quick experimentation, I don't want to be responsible for your burning hardware.

## Setup Notes

- Only required dependencies here are `batchtools` and `ggplot2`: `install.packages(c("batchtools", "ggplot2", "ranger"))`
- `batchtools.conf.R` sets up parallelization for this project only, overriding other config files you might have.
  **Adjust `ncpus` and `max.load` there according to your hardware capabilities!**

## Workflow

- Write your simulation function in `problems.R`.
- Write/wrap your algorithm to be applied on the data in `algorithms.R`.
- Think.
- Adjust `run-experiments.R` for your problems/algorithms/parameter settings
- Run `run-experiments.R`, wait a while. This will block the R session, so beware!
- Hope.
- Optionally run `monitor-running.R` to check on finished/expired jobs.
- Retrieve and analyze your results in `analyze-results.R`.
- Appreciate.
