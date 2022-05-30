test_that("btt_state() works", {

  state <- btt_state()

  expect_type(state, "character")
  expect_match(state, "^[12]\\.")
})
