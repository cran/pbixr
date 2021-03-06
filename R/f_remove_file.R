#' @title Remove a File in the '.pbix' Collection of Files
#' @description A '.pbix' is decompressed, making its collection of files
#' available for manipulation. A file is removed from the collection.
#' Files remaining in the collection are (1) compressed to form a modified
#' '.pbix' and (2) deleted.
#' @author Don Diproto
#' @param input_file_pbix Path of the input '.pbix'.
#' @param collection_files_pbix Directory of the collection of files.
#' @param output_pbix Path of the modified '.pbix'.
#' @param file_remove Name of file in the collection of files to be removed.
#' @return None
#' @seealso Uses: \code{\link{f_decompress_pbix}},
#' \code{\link{f_compress_pbix}}.
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
#' pathFileSampleMod <- file.path(temp_dir, "sample_modified_f20.pbix")
#' dirFileSampleMod <- file.path(temp_dir, "sample_modified_f20")
#' if(file.exists(pathFileSampleMod)) {
#'   file.remove(pathFileSampleMod)
#' }
#' if(dir.exists(dirFileSampleMod)) {
#'   unlink(dirFileSampleMod, recursive = TRUE)
#' }
#' # Run the function
#' f_remove_file(pathFileSample, dirFileSampleMod, pathFileSampleMod,
#' "DataModel")
#'   }
f_remove_file <- function(input_file_pbix, collection_files_pbix, output_pbix,
                          file_remove) {

  # Stop checks
  if (!file.exists(input_file_pbix)) {
    stop(".pbix doesn't exist", call. = FALSE)
  }
  if (file.exists(output_pbix)) {
    stop("modified .pibx exists", call. = FALSE)
  }
  if (dir.exists(collection_files_pbix)) {
    stop("decompressed .pbix exists", call. = FALSE)
  }

  # Run
  # .pbix is decompressed, making its collection of files available for
  # manipulation
  f_decompress_pbix(input_file_pbix, collection_files_pbix)
  decompressed_files <- list.files(collection_files_pbix, full.names = TRUE)
  # A file(s) is removed from the collection
  file_to_remove <- which(decompressed_files %in% file.path(
    collection_files_pbix, file_remove))
  if (length(decompressed_files) > 0) {
    file.remove(decompressed_files[file_to_remove])
  # Files remaining in the collection are (1) compressed to form a modified
  #  .pbix and (2) deleted.
    f_compress_pbix(collection_files_pbix, output_pbix)
    unlink(collection_files_pbix, recursive = TRUE)
  }
}
