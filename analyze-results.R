# Retrieve and analyze job results
library(batchtools)
library(ggplot2)

# Get results -------------------------------------------------------------
# reduceResultsDataTable() gives the raw results, and inner-joining (ijoin()) it with
# getJobPars() expands it with more job metadata
res <-  flatten(ijoin(reduceResultsDataTable(), getJobPars()))
res

# Plot results -------------------------------------------------------------
ggplot(res, aes(x = algorithm, y = error)) +
  facet_grid(problem ~ p, labeller = label_both) +
  geom_boxplot() +
  theme_minimal(base_size = 14)
