#' @title Render Data Codebook
#' @description Creates an Rmd file using the parameterized Rmd template "codebook"
#' @param data The dataframe to export and parse
#' @param filename The file name (with no extension) to export the codebook & data file as
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' render_codebook(mtcars, "cars")
#' @seealso
#'  \code{\link[rmarkdown]{render}}
#' @rdname render_codebook
#' @export
#' @importFrom rmarkdown render
render_codebook = function(data, filename, output_dir = here::here("assets/data/open_data/intermediate/")) {

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
