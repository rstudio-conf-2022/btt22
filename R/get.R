#' Get new files for a given state
#'
#' @description
#' This function adds new files to:
#' - your `R` directory
#' - your `testthat/tests` directory
#'
#' If `open` is `TRUE`, it will open the new files for editing.
#'
#' @inherit btt_reset_hard params return
#' @param open `logical` specifies if new files are opened for interactive
#'  editing
#'
#' @return `state`, invisibly; called for side effects.
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

  suppressMessages(
    gert::git_branch_checkout(state, repo = path_repo())
  )

  path_template <- fs::path(path_repo(), "inst/template")

  # files to be copied
  files_ussie <- NULL
  if (fs::dir_exists(path_template)) {
    files_ussie <- fs::dir_ls(path_template, recurse = TRUE, regexp = "\\.R$")
  }

  # nothing to be copied
  if (length(files_ussie) == 0) {
    cli::cli_alert_info("State {.val {state}} has no files to be copied.")
    return(invisible(state))
  }

  # list files to be copied
  cli::cli_alert_warning(
    "State {.val {state}} will copy files to your package:"
  )
  files_ussie_rel <- fs::path_rel(files_ussie, start = path_template)
  purrr::walk(
    files_ussie_rel,
    ~cli::cli_bullets(c("*" = "{.file {.x}}"))
  )
  cli::cli_verbatim("")

  proceed <- yesno::yesno("Proceed?")
  if (!proceed) {
    cli::cli_alert_danger("{.fn btt_get} has been aborted.")
    return(invisible(state))
  }

  # copy files
  fs::dir_copy(path_template, root$find_file("."), overwrite = TRUE)

  cli::cli_alert_success("Copied template-files for state {.val {state}}.")

  # restore old branch
  gert::git_branch_checkout(old_branch, repo = path_repo())

  # open new files for editing
  purrr::walk(files_ussie_rel, usethis::edit_file, open = open)


  invisible(state)
}

repo_dir_ls <- function(repo_path) {

  path <- fs::path(path_repo(), repo_path)

  if (!fs::dir_exists(path)) {
    return(NULL)
  }

  fs::dir_ls(path, recurse = TRUE, regexp = "\\.R$")
}
