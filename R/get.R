#' Get new files for a given state
#'
#' This function add new files to
#' - your `R` directory.
#' - your `tests` directory.
#'
#' @inherit btt_reset_hard params return
#' @param open `logical` specifies if new files are opened for interactive
#'  editing
#'
#' @examples \dontrun{
#' btt_get("2.1.2")
#' }
#' @export
#'
btt_get <- function(state, open = rlang::is_interactive()) {

  # validate
  root <- validate_package_name("ussie")
  state <- validate_state(state)

  # check out branch
  old_branch <- gert::git_branch(repo = path_repo())
  gert::git_branch_checkout(state, repo = path_repo())

  # files to be copied
  files_ussie_r <- repo_dir_ls("inst/template/R")
  files_ussie_testthat <- repo_dir_ls("inst/template/testthat")

  # nothing to be copied
  if (is.null(c(files_ussie_r, files_ussie_testthat))) {
    cli::cli_alert_info("No files to be copied.")
    return(invisible(state))
  }

  # TODO: list files to be copied
  cli::cli_alert_warning("This will copy new files:")
  cli::cli_verbatim("")

  proceed <- yesno::yesno("Proceed?")
  if (!proceed) {
    cli::cli_alert_danger("{.fn btt_get()} has been aborted.")
    return(invisible(state))
  }

  # copy R files
  if (!is.null(files_ussie_r)) {
    fs::dir_copy(
      fs::path(path_repo(), "inst/template/R"),
      root$find_file("R"),
      overwrite = TRUE
    )
  }

  # copy testthat files
  if (!is.null(files_ussie_testthat)) {
    fs::dir_copy(
      fs::path(path_repo(), "inst/template/testthat"),
      root$find_file("tests/testthat"),
      overwrite = TRUE
    )
  }

  cli::cli_alert_success("Copied template-files for state {.val {state}}.")

  # restore old branch
  gert::git_branch_checkout(old_branch, repo = path_repo())

  # TODO: open new files for editing

  invisible(state)
}

repo_dir_ls <- function(repo_path) {

  path <- fs::path(path_repo(), repo_path)

  if (!fs::dir_exists(path)) {
    return(NULL)
  }

  fs::dir_ls(path)
}
