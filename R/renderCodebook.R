#' @title Render Data Codebook
#' @description Creates an Rmd file using the parameterized Rmd template "codebook"
#' @param data The dataframe to export and parse
#' @param filename The file name (with no extension) to export the codebook & data file as
#' @param output_dir The directory to put the file, Default: the "intermediate" directory inside of open_data
#' using puddingR structure
#' @param overwrite Whether to overwrite the file if it already exists, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' render_codebook(mtcars, "cars")
#' }
#' @seealso
#'  \code{\link[rmarkdown]{render}}
#' @rdname render_codebook
#' @export
#' @importFrom rmarkdown render
render_codebook = function(data,
                           filename,
                           output_dir = paste0(getwd(), "/assets/data/open_data/intermediate/"),
                           overwrite = FALSE) {
  fullPath <- paste0(output_dir, "codebook_", filename, ".md")

  if (!overwrite && file.exists(fullPath)){
    stop("This file already exists. Either change your filename or switch to overwrite = TRUE and try again")
  }

  template <- system.file("rmarkdown", "templates", "codebook", "skeleton", "skeleton.Rmd", package = "puddingR")
  rmarkdown::render(
    input = template,
    params = list(
      data = data,
      filename = filename
    ),
    output_file = paste0("codebook_", filename, ".md"),
    output_dir = output_dir
  )
}
