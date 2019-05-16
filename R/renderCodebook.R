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
                           output_dir = "auto",
                           overwrite = FALSE) {

  fullPath <- dplyr::case_when(
    output_dir == "auto" ~ here::here("assets", "data", "open_data", "intermediate", paste0("codebook_", filename, ".md")),
    TRUE ~ paste0(output_dir, "codebook_", filename, ".md")
  )

  if (!overwrite && file.exists(fullPath)){
    stop("This file already exists. Either change your filename or switch to overwrite = TRUE and try again")
  }

  directory <- dplyr::case_when(
    output_dir == "auto" ~ here::here("assets", "data", "open_data", "intermediate"),
    TRUE ~ output_dir
  )

  template <- system.file("rmarkdown", "templates", "codebook", "skeleton", "skeleton.Rmd", package = "puddingR")
  rmarkdown::render(
    input = template,
    params = list(
      data = data,
      filename = filename
    ),
    output_file = paste0("codebook_", filename, ".md"),
    output_dir = directory
  )
}
