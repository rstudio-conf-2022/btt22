#' Get new files for a given state
#'
#' This function add new files to
#' - your `R` directory.
#' - your `tests` directory.
#'
#' @inherit btt_reset_hard params return
#'
#' @examples \dontrun{
#' btt_get("2.1.2")
#' }
#' @export
#'
btt_get <- function(state) {

  # validate
  root <- validate_package_name("ussie")
  state <- validate_state(state)

  cli::cli_alert_warning("This will copy new files into:")
  cli::cli_alert_info("Your {.file R} directory.")
  cli::cli_alert_info("Your {.file tests/testthat} directory.")
  cli::cli_verbatim("")

  proceed <- yesno::yesno("Proceed?")
  if (!proceed) {
    cli::cli_alert_danger("Get has been aborted.")
    return(invisible(NULL))
  }

  # check out branch
  old_branch <- gert::git_branch(repo = path_repo())
  gert::git_branch_checkout(state, repo = path_repo())

  # get R files
  fs::dir_copy(
    fs::path(path_repo(), "inst/template/R"),
    root$find_file("R"),
    overwrite = TRUE
  )

  # get testthat files
  fs::dir_copy(
    fs::path(path_repo(), "inst/template/testthat"),
    root$find_file("tests/testthat"),
    overwrite = TRUE
  )

  cli::cli_alert_success("Copied template-files for state {.val {state}}.")

  # restore old branch
  gert::git_branch_checkout(old_branch, repo = path_repo())

  invisible(state)
}
