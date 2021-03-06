#' @title Search '.xml' Within 'DataMashup'
#' @description A helper for searches of an '.xml' within 'DataMashup'.
#' @author Don Diproto
#' @param input_xml '.xml' that will be searched
#' @param search_string String for search
#' @param option option for the type of '.xml' search.
#' @return Search results
#' @import dplyr xml2
#' @export
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
#' # Get the start and end positions
#' test <- f_get_dama_xml_details(pathFileSample)
#' xml_start <- (test[[1]][1]/2) + 1
#' xml_end <- test[[3]][1]
#' # Get the .xml Within DataMashup
#' output <- f_get_dama_xml(pathFileSample, xml_start, xml_end)
#' # Pattern for query names
#' get_line <- "//ItemLocation[ItemType = \"Formula\"]//ItemPath"
#' # Run the function
#' f_search_xml(output, get_line, 1)
#'   }
f_search_xml <- function(input_xml, search_string, option) {
  if (option == 1) {
    o1 <- input_xml %>%
      xml2::xml_find_all(search_string) %>%
      xml2::xml_text()
  } else {
    o1 <- input_xml %>%
      xml2::xml_find_all(search_string)
    }
  return(o1)
}
