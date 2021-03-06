% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_local_candidates.R
\name{get_candidate_id}
\alias{get_candidate_id}
\title{Get Candidate Campaign Committee MA OCPF ID}
\usage{
get_candidate_id(name, df = all_candidate_info, search_last_name_only = FALSE)
}
\arguments{
\item{name}{character string with candidate name or part of name}

\item{df}{data frame resulting from running get_local_candidates() function}

\item{search_last_name_only}{logical whether to search last name only, defaults to FALSE}
}
\value{
data frame with column for MA OCPF candidate ID
}
\description{
Get Candidate Campaign Committee MA OCPF ID
}
