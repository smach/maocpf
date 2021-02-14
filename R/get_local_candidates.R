

#' Get all candidates throughout Massachusetts - downloads full data each time
#' Suggest running once per session with defaults and then filtering later on community or office. Data downloads to temp subdirectory of your working directory (will be created if it doesn't exist).
#'
#' @param place character string defaults to "" to load all
#' @param office character string defaults to "" to load all
#' @param the_url character string for OCPF url to download zip file
#'
#' @return
#' @export
#'
get_local_candidates <- function(place = "", office = "", the_url = "https://ocpf2.blob.core.windows.net/downloads/data/registered-candidates.zip") {
  if(!dir.exists("temp")) {dir.create("temp")}
  the_dest_file <- "temp/candidates.zip"
  download.file(url = the_url, destfile = the_dest_file)
  unzip(the_dest_file, exdir = "temp")
  all_data <- readxl::read_xlsx("temp/registered-candidates.xlsx", sheet = 2)
  if(place != "") {
    all_data <- dplyr::filter(all_data, Comm_City == place)
  }
  if(office != "") {
    all_data <- dplyr::filter(all_data, stringr::str_detect(tolower(office), tolower(Office_Type)) )
  }

  return(all_data)
}



#' Get Candidate Campaign Committee MA OCPF ID
#'
#' @param name character string with candidate name or part of name
#' @param df data frame resulting from running get_local_candidates() function
#' @param search_last_name_only logical whether to search last name only, defaults to FALSE
#'
#' @return data frame with column for MA OCPF candidate ID
#' @export
#'
get_candidate_id <- function(name, df = all_candidate_info, search_last_name_only = FALSE) {
  df <- dplyr::mutate(df, Candidate = paste(Candidate_First_Name, Candidate_Last_Name))
  if(!search_last_name_only) {

  df <- dplyr::filter(df, stringr::str_detect(tolower(Candidate), tolower(name))
                          )
  } else {
    df <- dplyr::filter(df, stringr::str_detect(tolower(Candidate_Last_Name), tolower(name)))
  }

  df <- dplyr::select(df, ID = CPF_ID, Candidate)
  return(df)
}
