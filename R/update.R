#' Internal function to incorporate ussie repo
#'
#' @noRd
#'
btt_update_ussie <- function() {

  # validate
  root <- validate_package_name("btt22")

  # download repo to temp directory
  path_temp <- withr::local_tempdir()

  cli::cli_inform(
    c(i = "Retrieving ussie repo from remote source: {.url {url_ussie()}}")
  )
  gert::git_clone(url_ussie(), path = path_temp)

  zip_file <- root$find_file("inst/ussie-repo/ussie.zip")

  withr::local_dir(path_temp)
  zip::zip(zip_file, files = fs::dir_ls(all = TRUE))

  cli::cli_alert_success("New ussie repo at {.file {zip_file}}")

  invisible(NULL)
}
