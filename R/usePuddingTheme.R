usePuddingTheme <- function(toc = TRUE,
                            code_folding = "show",
                            number_sections = FALSE) {

  # get the locations of resource files located within the package
  css <- system.file("rmarkdown", "templates", "pudding", "resources", "style.css", package = "puddingR")
  #template <-system.file("rmarkdown", "templates", "pudding", "resources", "template_pudding.html", package = "puddingR")

  # call the base html_document function
  rmarkdown::html_document(theme = "lumen",
                           css = css,
                           toc = toc,
                           toc_float = TRUE,
                           toc_depth = 2,
                           number_sections = number_sections,
                           df_print = "paged",
                           code_folding = code_folding,
                           )
}
