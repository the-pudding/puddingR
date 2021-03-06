% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/exportData.R
\name{export_all}
\alias{export_all}
\title{Export Data, Codebook, and Scripts}
\usage{
export_all(data, filename, location = c("processed", "open"),
  directory = "auto", format = "csv", na = "", codebook = FALSE,
  codebook_dir = "auto", scripts = NULL, script_file,
  script_dir = "auto")
}
\arguments{
\item{data}{Data frame to export}

\item{filename}{the name of the exported file, without the extension}

\item{location}{If using the puddingR file directory, automatically place the file inside either the open_data folder ("open")
the processed_data ("processed"), or outside of the R directory, and in the larger Pudding starter template ("js"), Default: 'open'}

\item{directory}{Directory of the exported file. If set to "auto", this assumes that the project follows the
puddingR structure. Otherwise, the "location" parameter is overwritten by the directory in this argument, Default: 'auto'}

\item{format}{file output format (either "csv", "json", or "tsv"), Default: 'csv'}

\item{na}{How to export NA values, Default: ''}

\item{codebook}{Whether to export a codebook using the render_codebook() function, Default: FALSE}

\item{codebook_dir}{Where to export the codebook, default assumes using the puddingR file structure, Default: "auto"
which outputs to the "open_data/intermediate" folder.}

\item{scripts}{Character vector of code chunk names to export to a .R script, Default: NULL}

\item{script_file}{The .Rmd file to find the code chunks in (requires directory to find file)}

\item{script_dir}{Directory of where to put the resulting .R script. Defaults to the "open_data" directory in
puddingR template, Default: 'auto'}
}
\value{
OUTPUT_DESCRIPTION
}
\description{
Export any dataframe that has been processed in R with additional options to also
produce a codebook and relevant scripts
}
\details{
DETAILS
}
\examples{
\dontrun{
# assuming use of puddingR file template
export_all(mtcars, "cars", codebook = TRUE, scripts = c("load_packages", "analyze_data"),
script_file = "analysis.Rmd")

 # assuming not using puddingR template
 export_all(mtcars, "cars", directory = "data/my_data/",
 codebook = TRUE, codebook_dir = "data/codebooks/")
}
}
\seealso{
\code{\link[purrr]{map}}
 \code{\link[dplyr]{case_when}}
 \code{\link[here]{here}}
}
