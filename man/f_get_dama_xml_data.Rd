% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f_get_dama_xml_data.R
\name{f_get_dama_xml_data}
\alias{f_get_dama_xml_data}
\title{Get Data from an '.xml' within 'DataMashup'}
\usage{
f_get_dama_xml_data(input_file_xml)
}
\arguments{
\item{input_file_xml}{The '.xml' within 'DataMashup'.}
}
\value{
Data from the '.xml' within 'DataMashup'.
}
\description{
The '.xml' extracted from 'DataMashup' is queried.
}
\examples{
\dontrun{
# Get dummy data ------------------------------------------------------------
# Create a temporary directory
temp_dir <- file.path(tempdir(),"functionTest")
if(!dir.exists(temp_dir)) {
	dir.create(temp_dir)
}
sample_file_name <- "OR_sample_func.pbix"
pathFileSample <- file.path(temp_dir, sample_file_name)

# See if dummy data already exists in temporary directory
parent_temp_dir <- dirname(temp_dir)
existing_file <- list.files(parent_temp_dir,
pattern = sample_file_name, recursive = TRUE, full.names = TRUE)

# Download the sample .pbix if it doesn't exist
if (length(existing_file) == 0) {
   url_pt1 <- "https://github.com/KoenVerbeeck/PowerBI-Course/blob/"
   url_pt2 <- "master/pbix/TopMovies.pbix?raw=true"
   url <- paste0(url_pt1, url_pt2)
   req <- download.file(url, destfile = pathFileSample, mode = "wb")
} else {
   pathFileSample <- existing_file[1]
}
# Do stuff ------------------------------------------------------------------

# Get the start and end positions
test <- f_get_dama_xml_details(pathFileSample)
xml_start <- (test[[1]][1]/2) + 1
xml_end <- test[[3]][1]
# Get the .xml Within DataMashup
output <- f_get_dama_xml(pathFileSample, xml_start, xml_end)
# Run the function
get_xml_data <- f_get_dama_xml_data(output)
  }
}
\seealso{
Uses: \code{\link{f_search_xml}}.
}
\author{
Don Diproto
}
