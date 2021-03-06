#' @title Read Layout as '.json' from the '.pbix' Collection of Files
#' @description The byte sequence of Layout within a '.pbix' is retrieved,
#' cleaned by removing ASCII control characters and written to a temporary file
#' . An attempt is made to read the temporary file as '.json'. If reading
#'  the temporary file as '.json' fails, a second attempt is made. For the
#'  second attempt, specific data within the '.json' file is included and a
#'  temporary file is written. The temporary file is read as '.json'.
#' @author Don Diproto
#' @param input_file_pbix Path of the input '.pbix'.
#' @param gsub1 Text to select for replacement (i.e. text to exclude).
#' @param gsub2 Text to replace selected text (i.e. text to include).
#' @return json: Layout
#' @import jsonlite
#' @importFrom textclean replace_non_ascii
#' @export
#' @seealso Uses: \code{\link{f_read_any_json}}.
#' @examples
#' \dontrun{
#' # Get dummy data ------------------------------------------------------------
#' # Create a temporary directory
#' temp_dir <- file.path(tempdir(),"functionTest")
#' if(!dir.exists(temp_dir)) {
#' 	dir.create(temp_dir)
#' }
#' sample_file_name <- "OR_sample_func.pbix"
#' pathFileSample <- file.path(temp_dir, sample_file_name)
#'
#' # See if dummy data already exists in temporary directory
#' parent_temp_dir <- dirname(temp_dir)
#' existing_file <- list.files(parent_temp_dir,
#' pattern = sample_file_name, recursive = TRUE, full.names = TRUE)
#'
#' # Download the sample .pbix if it doesn't exist
#' if (length(existing_file) == 0) {
#'    url_pt1 <- "https://github.com/KoenVerbeeck/PowerBI-Course/blob/"
#'    url_pt2 <- "master/pbix/TopMovies.pbix?raw=true"
#'    url <- paste0(url_pt1, url_pt2)
#'    req <- download.file(url, destfile = pathFileSample, mode = "wb")
#' } else {
#'    pathFileSample <- existing_file[1]
#' }
#' # Do stuff ------------------------------------------------------------------
#'
#' gsub__1 <- paste0(".*sections")
#' gsub__2 <- "\{\"id\":0,\"sections"
#' # Run the function
#' test <- f_read_layout(pathFileSample, gsub__1, gsub__2)
#'   }
f_read_layout <- function(input_file_pbix, gsub1, gsub2) {
  layout <- f_read_any_json(input_file_pbix, "Report/Layout", gsub1, gsub2)
  return(layout)
}
