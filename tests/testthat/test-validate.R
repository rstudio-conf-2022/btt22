test_that("validate_state() works", {

  expect_error(validate_state("foo"), class = "btt22_state")

  state <- expect_invisible(validate_state("2.1.1"))
  expect_identical(state, "2.1.1")
})
