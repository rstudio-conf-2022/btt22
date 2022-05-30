btt_get <- function(state) {

  # validate
  root <- validate_ussie()
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


  cli::cli_alert_success("Copied template-files for state {.val {state}}.")

  # restore old branch
  gert::git_branch_checkout(old_branch, repo = path_repo())

  invisible(state)
}
