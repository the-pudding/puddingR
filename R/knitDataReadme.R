#' @title Knit Codebooks to Single README
#' @description Combine all other generated codebooks into a single README file for a data repository
#' @param directory File directory of the existing codebooks, Default: paste0(getwd(), "/assets/data/open_data/intermediate/")
#' @param filename Name of output file, Default: 'README'
#' @param output_dir File directory for final README, Default: paste0(getwd(), "/assets/data/open_data/")
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
knit_data_readme = function(directory = paste0(getwd(), "/assets/data/open_data/intermediate/"),
                            filename = "README",
                            output_dir = paste0(getwd(), "/assets/data/open_data/")) {

  fullPath <- paste0(output_dir, filename, ".md")

  template <- system.file("rmarkdown", "templates", "data_readme", "skeleton", "skeleton.Rmd", package = "puddingR")
  rmarkdown::render(
    input = template,
    params = list(
      directory = directory
    ),
    output_file = paste0(filename, ".md"),
    output_dir = output_dir
  )
}
