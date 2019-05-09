#writeToFile <- function(data, filename, type = "csv", customDir = NA, outputJS = FALSE, outputDataRepo = FALSE, na = '', append = FALSE){

  # # set the path for the data repo directory
  # dataRepoDir <- ifelse(outputDataRepo == FALSE, NA, here::here("processed_data", "for_repo"))
  #
  # # create the data repo directory if it doesn't already exist
  # if(outputDataRepo == TRUE && file.exists(dataRepoDir) == FALSE){
  #   dir.create(dataRepoDir)
  # }
  #
  # # set the path for the js directory
  # jsPath <- ifelse(outputJS == FALSE, NA, "../src/assets/data/")
  #
  #
  # # make a character vector of all directories
  # directories <- c(dataRepoDir, jsPath, customDir)
  # # and remove any that are NA
  # directories[!is.na(directories)]
  #
  # # write out the file to all of the locations needed
  # if (type == "csv"){
  #   walk(directories, function(d){
  #     utils::write.csv(x = data, file = paste0(d, filename, ".csv"), append = append,
  #                      na = na, row.names = FALSE)
  #   })
  # }
#}
