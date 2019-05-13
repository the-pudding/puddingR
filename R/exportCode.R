#' @title Export several code chunks from Rmd to R
#' @description For use in creating a data repo, indicate all the code chunks used to create a specific subset of data
#' @param file The .Rmd file to parse
#' @param toKeep A character vector of the code chunk labels to keep
#' @param outputFile The filename to write to (no extension)
#' @param outputDir The directory to write the file to (ending with trailing slash), Default: "auto"
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' # In the puddingR default directory
#' export_code("analysis.Rmd", toKeep = c("load_data", "find_average"), outputFile = "average")
#'
#' #' # If not in the puddingR default directory
#' export_code("analysis.Rmd", toKeep = c("load_data", "find_average"), outputFile = "average", outputDir = "myFolder/")
#' }
#' @seealso
#'  \code{\link[dplyr]{case_when}}
#'  \code{\link[knitr]{knit}},\code{\link[knitr]{read_chunk}},\code{\link[knitr]{character(0)}}
#'  \code{\link[purrr]{map}}
#' @rdname export_code
#' @export
#' @importFrom dplyr case_when
#' @importFrom knitr purl read_chunk knit_code
#' @importFrom purrr walk

export_code <- function(file,
                        toKeep,
                        outputFile,
                        outputDir = "auto"){

  directory <- dplyr::case_when(
    outputDir == "auto" ~ paste0(getwd(), "assets/data/open_data/"),
    TRUE ~ outputDir
  )

  fullDirectory <- paste0(directory, outputFile, ".R")

  allChunks <- knitr::purl(file)


  knitr::read_chunk(allChunks)

  # collect all of the code for all code chunks in a file
  chunks <- knitr:::knit_code$get()

  # subset the list of code chunks
  toPrint <- chunks[toKeep]

  # for each code chunk that is kept, append it to an R script file
  purrr::walk(.x = toPrint, .f = function(x){
    write(x, fullDirectory, append = TRUE)
  })

  unlink(allChunks) # delete original purl script

  knitr:::knit_code$restore() # remove chunks from current knitr session
}

