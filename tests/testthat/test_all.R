context("get_dataset_ids")
test_that("get_dataset_ids works as expected", {
  df1 <- get_dataset_ids()
  expect_true("tbl_df" %in% class(df1))
  expect_true(nrow(df1) > 0)
  expect_identical(colnames(df1), "id")
})

context("get_dataset_info")
test_that("get_dataset_info works as expected with available datasets", {
  id <- "kuntaluettelo"
  l1 <- get_dataset_info(id)
  expect_true(class(l1) == "list")
  expect_equal(names(l1), c("organization", "license", "datasets", "notes"))
  df1 <- l1$datasets
  expect_true("tbl_df" %in% class(df1))
  expect_true(nrow(df1) > 0)
  expect_identical(colnames(df1), c("name", "format", "url"))
})

test_that("get_dataset_info works as expected with no available datasets", {
  id <- "yhdyskuntarakenteen-vyohykkeet-2015"
  l1 <- get_dataset_info(id)
  expect_true(class(l1) == "list")
  expect_equal(names(l1), c("organization", "license", "datasets", "notes"))
  expect_null(l1$datasets)
})

# test_that("get_dataset_info uses 'url_encode' as expeted", {
#   id <- "valtion-henkilosto"
#   res_t <- get_dataset_info(id, url_encode = TRUE)
#   res_f <- get_dataset_info(id, url_encode = FALSE)
#   expect_false(identical(res_t$datasets$url, res_f$datasets$url))
# })

test_that("get_dataset_info works as expected with id that does not exist", {
  id <- "this_does_not_exist"
  expect_error(get_dataset_info(id), "error")
})
