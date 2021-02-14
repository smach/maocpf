
<!-- README.md is generated from README.Rmd. Please edit that file -->

# maocpf

<!-- badges: start -->
<!-- badges: end -->

The goal of maocpf is to pull candidate fundraising data from the
Massachusetts Office of Campaign and Political Finance.

Here’s a typical workflow.

## Setup: Once or infrequently

1.  Get a list of all local candidates with `get_local_candidates()`.
    This function downloads a file with all candidates from the MA OCPF
    Web site to a temp subdirectory (which will be created if it doesn’t
    exist). You can filter by city and/or office, but it’s probably
    better to stick to the default and download the full list once. Then
    you can filter that unless you are 100% sure you only want the
    filtered version. The file downloads each time you run this
    function.

2.  Get the IDs of the candidates you want with `get_candidate_id()`
    using the candidate name as the first argument and the data frame
    you created in step 1 as the second argument. *Store this data
    somewhere for re-use!*

Here is a sample workflow to begin using this package:

``` r
library(maocpf)
all_candidate_info <- get_local_candidates()
save(all_candidate_info, "data/all_candidate_info.Rdata")

all_framingham_candidates <- dplyr::filter(all_candidate_info, Candidate_City == "Framingham")
save(all_framingham_candidates, "data/all_framingham_candidates.Rdata")
```

Note that for state legislative districts that encompass areas outside
of one community, you’ll want to filter by District column instead.

Data for `all_candidate_info` and `all_framingham_candidates` from
February 14, 2021 are included with this package.

## Run regularly

To get up-to-date data on a candidate, use the
`get_candidate_contribution_data()` function with the candidate’s ID.
For example, I can find Framingham Mayor Spicer’s ID with the
get\_candidate\_id() function and all or part of her name:

``` r
get_candidate_id("Spicer")
#> # A tibble: 1 x 2
#>   ID    Candidate       
#>   <chr> <chr>           
#> 1 16676 Yvonne M. Spicer
```

Now I can pull all the contributions since the start of 2021 with

``` r
spicer_contributions <- get_latest_candidate_contributions("16676", "2021-01-01")
head(spicer_contributions)
#>         Date         Candidate FirstName LastName              Address
#> 1 2021-01-08 Spicer, Yvonne M.      Eric     Masi      68 Lowell Drive
#> 2 2021-01-14 Spicer, Yvonne M.      Mary    Breen     52 Arthur Street
#> 3 2021-01-14 Spicer, Yvonne M.     Burns    Burns      16 Acorn Street
#> 4 2021-01-14 Spicer, Yvonne M.     Stacy    Cowan    3 Stonegate Drive
#> 5 2021-01-14 Spicer, Yvonne M.    George     Deak 76 Florissant Avenue
#> 6 2021-01-14 Spicer, Yvonne M.     Janet    Drake         66 Linda Ave
#>         City State ZipCode Amount                   Occupation
#> 1       Stow    MA   01775    200 Social Service Administrator
#> 2 Framingham    MA   01702     25                 Not Employed
#> 3     Boston    MA   02108    500                 Not Employed
#> 4   Westwood    MA   02090   1000                       Lawyer
#> 5 Framingham    MA   01701     25                 Not Employed
#> 6 Framingham    MA   01701     15            Circulation Asst.
#>                                Employer                 Report
#> 1 Wayside Youth &family Support Network  1/8/21 Deposit Report
#> 2                          Not Employed 1/14/21 Deposit Report
#> 3                          Not Employed 1/14/21 Deposit Report
#> 4                 Slc Advisory Services 1/14/21 Deposit Report
#> 5                          Not Employed 1/14/21 Deposit Report
#> 6     Town of Framingham (Library Dept) 1/14/21 Deposit Report
```

To get a data frame with multiple candidates, simply use
`purrr::map_df()` to get a list of candidate IDs and then download their
contribution data, such as:

``` r
my_ids_df <- purrr::map_df(c("Spicer", "King", "Steiner", "Stefanini"), get_candidate_id, df = all_framingham_candidates)
my_ids_df
#> # A tibble: 4 x 2
#>   ID    Candidate          
#>   <chr> <chr>              
#> 1 16676 Yvonne M. Spicer   
#> 2 16997 George P. King, Jr.
#> 3 16720 Adam C. Steiner    
#> 4 12372 John A. Stefanini
```

``` r
contributions2021 <- purrr::map_df(my_ids_df$ID, get_latest_candidate_contributions, start_date = "2021-01-01")
```

## Installation

This package is not on CRAN, so you can only install it from GitHub.
Install with your favorite install-from-GitHub package such as
`remotes::install_github("smach/maocpf")`

<!--  `devtools::build_readme()` is handy for this. You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/master/examples>. -->
