# This config files overrides any other batchtools config files for the current project
# Here we parallelize locally over `ncpus` threads. Set according to your systems capabilities
# Set `max.load` to a value slightly higher than `ncpus`. This is the system load that, once reached, will make
# batchtools stop submitting more jobs even if there were CPUs/threads available.
#
# If your system has 10 CPUs, keep some room for the OS and stuff by setting ncpus = 8 and max.load = 8 (default is max.load = ncpus)

cluster.functions <- makeClusterFunctionsSSH(list(Worker$new("localhost", ncpus = 8, max.load = 9)))
