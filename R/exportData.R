#' @title Export Data
#' @description Export any dataframe that has been processed in R with additional options to also produce a codebook
#' @param data Data frame to export
#' @param filename the name of the exported file, without the extension
#' @param location If using the puddingR file directory, automatically place the file inside either the open_data folder ("open")
#' the processed_data ("processed"), or outside of the R directory, and in the larger Pudding starter template ("js"), Default: 'open'
#' @param directory Directory of the exported file. If set to "auto", this assumes that the project follows the
#' puddingR structure. Otherwise, the "location" parameter is overwritten by the directory in this argument, Default: 'auto'
#' @param format file output format (either "csv", "json", or "tsv"), Default: 'csv'
#' @param na How to export NA values, Default: ''
#' @param codebook Whether to export a codebook using the render_codebook() function, Default: FALSE
#' @param codebookDir Where to export the codebook, default assumes using the puddingR file structure, Default: here::here("assets", "data", "open_data", "intermediate/")
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' # assuming use of puddingR file template
#' export_data(mtcars, "cars", codebook = TRUE)
#'
#'  # assuming not using puddingR template
#'  export_data(mtcars, "cars", directory = "data/my_data/",
#'  codebook = TRUE, codebookDir = "data/codebooks/")
#' }
#' @seealso
#'  \code{\link[here]{here}}
#'  \code{\link[purrr]{map}}
#' @rdname export_data
#' @export
#' @importFrom purrr walk
export_data <- function(data, filename,
                        location = c("processed", "open"),
                        directory = "auto",
                        format = "csv",
                        na = "",
                        codebook = FALSE,
                        codebookDir = paste0(getwd(), "/assets/data/open_data/intermediate")){
  # write data to one or multiple locations simultaneously
  purrr::walk(.x = location, .f = function(x){
    export_processed(data, filename, location = x, directory, format, na)
  })

  if (codebook) {
    render_codebook(data, filename, output_dir = codebookDir)
  }
}

#' @title Export Processed Data
#' @description Export any dataframe that has been processed in R
#' @param data data frame to export
#' @param filename the name of the exported file, without the extension
#' @param location If using the puddingR file directory, automatically place the file inside either the open_data folder ("open")
#' the processed_data ("processed"), or outside of the R directory, and in the larger Pudding starter template ("js"), Default: 'open'
#' @param directory Directory of the exported file. If set to "auto", this assumes that the project follows the
#' puddingR structure. Otherwise, the "location" parameter is overwritten by the directory in this argument, Default: 'auto'
#' @param format file output format (either "csv", "json", or "tsv"), Default: 'csv'
#' @param na How to export NA values, Default: ''
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' # export a csv using the puddingR template
#' export_processed(mtcars, "cars")
#'
#' # export as json using the puddingR template
#' export_processed(mtcars, "cars", format = "json")
#'
#' # output csv to a location not using the puddingR template
#' export_processed(mtcars, "cars", directory = "data/my_data/")
#' }
#' @seealso
#'  \code{\link[dplyr]{case_when}}
#' @rdname export_processed
#' @export
#' @importFrom dplyr case_when
#' @importFrom here here

export_processed <- function(data, filename, location = "open", directory = "auto", format = "csv", na = ""){
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
