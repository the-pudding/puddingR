#' @title createFileStructure
#' @description Creates a new R project with the folder structure used in Pudding R projects
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[usethis]{create_package}},\code{\link[usethis]{use_directory}}
#'  \code{\link[rstudioapi]{isAvailable}}
#'  \code{\link[base]{c}}
#'  \code{\link[purrr]{map2}}
#' @rdname createFileStructure
#' @export
#' @param directory Parent directory for the project to be created in. If the typed directory does not exist, it will be created., Default: 'analysis'
#' @importFrom usethis create_project use_directory
#' @importFrom rstudioapi isAvailable
#' @importFrom purrr map2

createFileStructure <- function(directory = "analysis"){

  parentDir <- directory

  # Create new R Project
  usethis::create_project(parentDir, rstudio = rstudioapi::isAvailable(),
  open = interactive())

  # Remove the added R folder in favor of our specific file structure
  file.remove("Analysis/R")

  # Create Pudding file structure
  childDir <- c("assets", "functions", "open_data", "plots", "processed_data", "raw_data", "reports", "rmds", "rscripts")

  purrr::map2(.x = childDir, .y = FALSE, .f = usethis::use_directory)

  # Create a runAll R script
  file.create(paste0(parentDir, "/run_all.R"))
}
