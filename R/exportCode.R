#' @title Export several code chunks from Rmd to R
#' @description For use in creating a data repo, indicate all the code chunks used to create a specific subset of data
#' @param file The .Rmd file to parse
#' @param chunks A character vector of the code chunk labels to keep
#' @param output_file The filename to write to (no extension)
#' @param output_dir The directory to write the file to (ending with trailing slash), Default: "auto"
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' # In the puddingR default directory
#' export_code("analysis.Rmd", chunks = c("load_data", "find_average"), output_file = "average")
#'
#' #' # If not in the puddingR default directory
#' export_code("analysis.Rmd", chunks = c("load_data", "find_average"),
#' output_file = "average", output_dir = "myFolder/")
#' }
#' @seealso
#'  \code{\link[dplyr]{case_when}}
#'  \code{\link[knitr]{knit}},\code{\link[knitr]{read_chunk}}
#'  \code{\link[purrr]{map}}
#' @rdname export_code
#' @export
#' @importFrom dplyr case_when
#' @importFrom knitr purl read_chunk knit_code
#' @importFrom purrr walk

export_code <- function(file,
                        chunks,
                        output_file,
                        output_dir = "auto"){


  directory <- dplyr::case_when(
    output_dir == "auto" ~ here::here("assets", "data", "open_data"),
    TRUE ~ output_dir
  )

  if (!file.exists(directory)) stop(paste0(directory, "doesn't exist. Either use the puddingR file structure or change the directory argument."))

  fullDirectory <- dplyr::case_when(
    output_dir == "auto" ~ here::here("assets", "data", "open_data", paste0(output_file, ".R")),
    TRUE ~ paste0(output_dir, output_file, ".R")
  )

  print(paste0("exporting to:", fullDirectory))

  allChunks <- knitr::purl(file)

  knitr::read_chunk(allChunks)

  # collect all of the code for all code chunks in a file
  chunks <- knitr::knit_code$get()

  # subset the list of code chunks
  toPrint <- chunks[chunks]

  # for each code chunk that is kept, append it to an R script file
  purrr::walk(.x = toPrint, .f = function(x){
    write(x, fullDirectory, append = TRUE)
  })

  unlink(allChunks) # delete original purl script

  knitr::knit_code$restore() # remove chunks from current knitr session
}

