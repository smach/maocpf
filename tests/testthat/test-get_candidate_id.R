library(maocpf)
library(testthat)


test_that("get_id_works", {
  expect_equal(get_candidate_id("Spicer")$ID[1], "16676")
  expect_equal(get_candidate_id("Stefanini", search_last_name_only = TRUE )$ID[1], "12372")
})
