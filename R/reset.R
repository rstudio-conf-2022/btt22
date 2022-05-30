#' Reset ussie to a fixed state
#'
#' This function completely overwrites:
#' - your `R` directory.
#' - your `tests` directory.
#' - the `Imports` and `Suggests` sections of your `DESCRIPTION` file.
#'
#' This function must be called interactively, where the current working
#' directory is within an R package named **ussie**. This is to prevent
#' you from accidentially blowing away your work in a different project.
#'
#' @param state `character`, use [btt_state()] to see available states.
#'
#' @return `state`, invisibly.
#' @examples \dontrun{
#' btt_state("2.1.1")
#' }
#' @export
#'
btt_reset <- function(state) {

  # validate
  root <- validate_ussie()
  state <- validate_state(state)

  cli::cli_alert_warning("This will overwrite:")
  cli::cli_alert_info("The entire contents of the {.file R} directory.")
  cli::cli_alert_info("The entire contents of the {.file tests} directory.")
  cli::cli_alert_info(
    "The {.field Imports} and {.field Suggests} fields of the {.file DESCRIPTION} file."
  )
  cli::cli_verbatim("")

  proceed <- yesno::yesno("Proceed?")
  if (!proceed) {
    cli::cli_alert_danger("Reset has been aborted.")
    return(invisible(state))
  }

  # check out branch
  old_branch <- gert::git_branch(repo = path_repo())
  gert::git_branch_checkout(state, repo = path_repo())

  # replace `R` directory
  fs::dir_delete(root$find_file("R"))
  fs::dir_copy(fs::path(path_repo(), "R"), root$find_file("R"))

  # replace `tests` directory
  fs::dir_delete(root$find_file("tests"))
  fs::dir_copy(fs::path(path_repo(), "tests"), root$find_file("tests"))

  # update DESCRIPTION
  path_desc_remote <- fs::path(path_repo(), "DESCRIPTION")
  desc::desc_set(
    Imports = desc::desc_get_field("Imports", file = path_desc_remote),
    Suggests = desc::desc_get_field("Suggests", file = path_desc_remote),
    file = root$find_file("DESCRIPTION"),
    normalize = TRUE
  )

  cli::cli_alert_success("Updated to state {.val {state}}.")

  # restore old branch
  gert::git_branch_checkout(old_branch, repo = path_repo())

  invisible(state)
}
