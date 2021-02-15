library(maocpf)
library(testthat)
library(dplyr)
spicer_2020_start <- get_latest_candidate_contributions("16676", "2020-01-01")

spicer2020_all <- spicer_2020_start %>%
  filter(Date < as.Date("2021-01-01"))

spicer2020_framingham <- filter(spicer2020_all, City == "Framingham")

spicer2020_sum <- sum(spicer2020_all$Amount, na.rm = TRUE)

test_that("get_id_works", {
  expect_equal(get_candidate_id("Spicer")$ID[1], "16676")
  expect_equal(get_candidate_id("Stefanini", search_last_name_only = TRUE )$ID[1], "12372")
})

test_that("get_latest_candidate_contributions works", {
  expect_equal(spicer2020_sum, 37523.47)
  expect_equal(nrow(spicer2020_all), 342)
  expect_equal(nrow(spicer2020_framingham), 128)
  expect_equal(sum(spicer2020_framingham$Amount, na.rm = TRUE), 13641.67)
})
