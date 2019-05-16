#' @title Knit Codebooks to Single README
#' @description Combine all other generated codebooks into a single README file for a data repository
#' @param input_dir File directory of the existing codebooks, Default: "auto", assumes puddingR file directory
#' and uses the "intermediate" folder inside "open_data"
#' @param filename Name of output file, Default: 'README'
#' @param output_dir File directory for final README, Default: "auto", assumes puddingR file directory, outputs to
#' the "open_data" directory
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' # using puddingR file structure
#' knit_data_readme()
#'
#' # using other file structure
#' knit_data_readme(directory = "my_codebooks", output_dir = "public_data")
#' }
#' @seealso
#'  \code{\link[rmarkdown]{render}}
#' @rdname knit_data_readme
#' @export
#' @importFrom rmarkdown render
knit_data_readme = function(input_dir = "auto",
                            filename = "README",
                            output_dir = "auto") {

  inputDirectory <- dplyr::case_when(
    input_dir == "auto" ~ here::here("assets", "data", "open_data", "intermediate"),
    TRUE ~ input_dir
  )

  outputDirectory <- dplyr::case_when(
    output_dir == "auto" ~ here::here("assets", "data", "open_data"),
    TRUE ~ output_dir
  )



  template <- system.file("rmarkdown", "templates", "data_readme", "skeleton", "skeleton.Rmd", package = "puddingR")
  rmarkdown::render(
    input = template,
    params = list(
      directory = inputDirectory
    ),
    output_file = paste0(filename, ".md"),
    output_dir = outputDirectory
  )
}
