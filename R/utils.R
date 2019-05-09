#####################################
##### Dependencies management  #####
#####################################

### Many of these functions are from the `starters` R package

#' supported package dependency tools
#'
#' @noRd
okpackagedeps <- function() {
  c("none", "packrat", "checkpoint")
}

#' set up dependencies management
#'
#' @param packagedeps package dependency tool
#'
#' @noRd
setup_dep_system <- function(packagedeps) {
  if (packagedeps == "packrat") {
    desc::desc_set_dep(
      package = "packrat",
      type = "Imports",
      file = usethis::proj_get()
    )
    packrat::init(usethis::proj_get(), enter = FALSE)
  }

  if (packagedeps == "checkpoint") {
    desc::desc_set_dep(
      package = "checkpoint",
      type = "Imports",
      file = usethis::proj_get()
    )

    checkpoint::checkpoint(Sys.Date(),
                           project = usethis::proj_get(),
                           checkpointLocation = usethis::proj_get(),
                           forceProject = TRUE,
                           verbose = FALSE
    )
  }
}

##########################
##### Project Setup  #####
##########################

#' Create directories
#'
#' @param dirs Subfolders
#'
#' @noRd
#'
createDirectories <- function(dirs){
  # stop if no directories passed
  stopifnot(length(dirs) > 0)
  # generate full file paths for all dirs
  filePaths <- file.path(usethis::proj_get(), dirs)
  # if the directory doesn't already exist, create it
  purrr::map(filePaths, function(x){
    if (!dir.exists(x)) dir.create(x)
  })
}


#' Make DESCRIPTION
#'
#' @param name Package / project
#'
#' @noRd
createdesc <- function(name) {
  desc <- desc::desc("!new")
  desc$add_me(role = "cre")
  desc$write(file.path(name, "DESCRIPTION"))
}

##########################
##### Project Reset  #####
##########################

#' Get current project
#'
#' @noRd
getCurrentProj <- function(){
  # try to access the current proj directory or fail silently
  current <- try(usethis::proj_get(), silent = TRUE)
  # if the above step produced an error, set current to NULL
  if (inherits(current, "try-error")) {
    current <- NULL
  }
  # return the file path of the current project
  return(current)
}

#' Reset project to what it was before
#'
#' @noRd
resetProj <- function(current) {
  # set the active project to the project defined in the argument
  usethis::proj_set(current, force = TRUE)
}
