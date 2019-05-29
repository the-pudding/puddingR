#' @title Export Data, Codebook, and Scripts
#' @description Export any dataframe that has been processed in R with additional options to also
#' produce a codebook and relevant scripts
#' @param data Data frame to export
#' @param filename the name of the exported file, without the extension
#' @param location If using the puddingR file directory, automatically place the file inside either the open_data folder ("open")
#' the processed_data ("processed"), or outside of the R directory, and in the larger Pudding starter template ("js"), Default: 'open'
#' @param directory Directory of the exported file. If set to "auto", this assumes that the project follows the
#' puddingR structure. Otherwise, the "location" parameter is overwritten by the directory in this argument, Default: 'auto'
#' @param format file output format (either "csv", "json", or "tsv"), Default: 'csv'
#' @param na How to export NA values, Default: ''
#' @param codebook Whether to export a codebook using the render_codebook() function, Default: FALSE
#' @param codebook_dir Where to export the codebook, default assumes using the puddingR file structure, Default: "auto"
#' which outputs to the "open_data/intermediate" folder.
#' @param scripts Character vector of code chunk names to export to a .R script, Default: NULL
#' @param script_file The .Rmd file to find the code chunks in (requires directory to find file)
#' @param script_dir Directory of where to put the resulting .R script. Defaults to the "open_data" directory in
#' puddingR template, Default: 'auto'
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' # assuming use of puddingR file template
#' export_all(mtcars, "cars", codebook = TRUE, scripts = c("load_packages", "analyze_data"),
#' script_file = "analysis.Rmd")
#'
#'  # assuming not using puddingR template
#'  export_all(mtcars, "cars", directory = "data/my_data/",
#'  codebook = TRUE, codebook_dir = "data/codebooks/")
#' }
#'@seealso
#'  \code{\link[purrr]{map}}
#'  \code{\link[dplyr]{case_when}}
#'  \code{\link[here]{here}}
#' @rdname export_all
#' @export
#' @importFrom purrr walk
#' @importFrom dplyr case_when
#' @importFrom here here
export_all <- function(data, filename,
                        location = c("processed", "open"),
                        directory = "auto",
                        format = "csv",
                        na = "",
                        codebook = FALSE,
                        codebook_dir = "auto",
                        scripts = NULL,
                        script_file,
                        script_dir = "auto"){
  # write data to one or multiple locations simultaneously
  purrr::walk(.x = location, .f = function(x){
    export_data(data, filename, location = x, directory, format, na)
  })

  if (codebook) {
    create_codebook(data, filename, output_dir = codebook_dir)
  }

  if (!is.null(scripts)){
    scriptDir <- dplyr::case_when(
      script_dir == "auto" ~ here::here("assets", "data", "open_data"),
      TRUE ~ script_dir
    )

    export_code(script_file,
                chunks = scripts,
                output_file = filename,
                output_dir = script_dir)
  }
}

#' @title Export Processed Data
#' @description Export any dataframe that has been processed in R
#' @param data data frame to export
#' @param filename the name of the exported file, without the extension
#' @param location If using the puddingR file directory, automatically place the file inside either the open_data folder ("open")
#' the processed_data ("processed"), or outside of the R directory, and in the larger Pudding starter template ("js"), Default: 'processed'
#' @param directory Directory of the exported file. If set to "auto", this assumes that the project follows the
#' puddingR structure. Otherwise, the "location" parameter is overwritten by the directory in this argument, Default: 'auto'
#' @param format file output format (either "csv", "json", or "tsv"), Default: 'csv'
#' @param na How to export NA values, Default: ''
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' # export a csv using the puddingR template
#' export_data(mtcars, "cars")
#'
#' # export as json using the puddingR template
#' export_data(mtcars, "cars", format = "json")
#'
#' # output csv to a location not using the puddingR template
#' export_data(mtcars, "cars", directory = "data/my_data/")
#' }
#' @seealso
#'  \code{\link[dplyr]{case_when}}
#' @rdname export_data
#' @export
#' @importFrom dplyr case_when
#' @importFrom here here

export_data <- function(data, filename, location = "processed", directory = "auto", format = "csv", na = ""){
  acceptableLocations <- c("open", "processed", "js")
  if (directory == "auto" & !location %in% acceptableLocations) stop("The location you selected isn't one of the automatic options.
      Either upate your directory argument or set the location to open, processed, or js. See ?export_processed for more information")

  path <- dplyr::case_when(
    directory == "auto" & location == "open" ~ here::here("assets", "data", "open_data"),
    directory == "auto" & location == "processed" ~ here::here("assets", "data", "processed_data"),
    directory == "auto" & location == "js" ~ "../src/assets/data",
    TRUE ~ directory
  )

  if (!file.exists(path)) stop(paste0(path, "doesn't exist. Either use the puddingR file structure or change the directory argument."))

  print(paste0("Exporting file to", path))

  if (format == "csv") make_csv(data, path, filename, na)

  if (format == "json") make_json(data, path, filename, na)

  if (format == "tsv") make_tsv(data, path, filename, na)

}

#' helper function to export csv files
#'
#' @param data data file
#' @param path file path to directory
#' @param filename name without extension of new file
#' @param na how to encode NA values
#'
#' @noRd
make_csv <- function(data, path, filename, na){
  utils::write.csv(x = data,
                   file = paste0(path, "/", filename, ".csv"),
                   row.names = FALSE,
                   na = na)
}

#' helper function to export tsv files
#'
#' @param data data file
#' @param path file path to directory
#' @param filename name without extension of new file
#' @param na how to encode NA values
#'
#' @noRd
make_tsv <- function(data, path, filename, na){
  utils::write.table(x = data,
                   file = paste0(path, "/", filename, ".csv"),
                   row.names = FALSE,
                   na = na,
                   sep = "/t")
}



#' helper function to export json files
#'
#' @param data data file
#' @param path file path to directory
#' @param filename name without extension of new file
#' @param na how to encode NA values
#'
#' @noRd
make_json <- function(data, path, filename, na){
  json <- jsonlite::toJSON(data)
  readr::write_lines(x = json,
                     path = paste0(path, "/", filename, ".json"),
                     na = na)
}
