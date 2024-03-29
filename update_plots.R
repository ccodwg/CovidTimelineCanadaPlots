# Update plots of CovidTimelineCanada datasets #
# Author: Jean-Paul R. Soucy #

# Note: This script assumes the working directory is set to the root directory of the project.
# This is most easily achieved by using the provided CovidTimelineCanadaPlots.Rproj in RStudio.

# GitHub: This script assumes pre-existing authentication for pushing to the CovidTimelineCanadaPlots GitHub repository.

# load data
Covid19CanadaETL::load_datasets(path = NULL)

# update plots
Covid19CanadaETL::plot_datasets("plots")

# check for updated files
system2("git", "update-index --really-refresh")
status <- system2("git", "diff-index --quiet HEAD --")
if (status == 0) {
  # exit without update
  cat("No files have changed. Exiting without update...", fill = TRUE)
} else {
  # print files that changed
  system2("git", "diff --name-only HEAD")
  # stage data update
  cat("Staging files for update...", fill = TRUE)
  system2(
    command = "git",
    args = c("add",
             "plots/"
    )
  )
  # commit data update
  cat("Creating commit...", fill = TRUE)
  system2(
    command = "git",
    args = c("commit",
             "-m",
             paste0("\"Update plots: ", update_time, "\"")
    )
  )
  # push data update
  cat("Pushing plot update...", fill = TRUE)
  system2(
    command = "git",
    args = c("push")
  )
  # report success
  cat("Plot update successful!", fill = TRUE)
}
