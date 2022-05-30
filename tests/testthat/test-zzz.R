test_that("loading works", {
  path_ussie <- path_repo()

  expect_true(fs::dir_exists(path_ussie))
  expect_s3_class(gert::git_open(path_ussie), "git_repo_ptr")
})
