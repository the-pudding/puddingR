#' @title Use Pudding Theme
#' @description This is used within the YAML of a new Rmd document to use the Pudding Styled Theme
#' @param toc Whether to include a table of contents automatically, Default: TRUE
#' @param code_folding Should code be showing or hidden by default (options: "show", "hide"), Default: 'show'
#' @param number_sections Should each chapter be numbered by default?, Default: FALSE
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso
#'  \code{\link[rmarkdown]{html_document}}
#' @rdname puddingTheme
#' @export
#' @importFrom rmarkdown html_document
puddingTheme <- function(toc = TRUE,
                            code_folding = "show",
                            number_sections = FALSE) {

  # get the locations of resource files located within the package
  css <- system.file("rmarkdown", "templates", "pudding", "resources", "style.css", package = "puddingR")
  header <- system.file("rmarkdown", "templates", "pudding", "resources", "header.html", package = "puddingR")
  #template <-system.file("rmarkdown", "templates", "pudding", "resources", "template_pudding.html", package = "puddingR")

  # call the base html_document function
  rmarkdown::html_document(theme = "lumen",
                           css = css,
                           toc = toc,
                           toc_float = TRUE,
                           toc_depth = 3,
                           number_sections = number_sections,
                           df_print = "paged",
                           code_folding = code_folding,
                           includes = rmarkdown::includes(before_body = header)
                           )
}
