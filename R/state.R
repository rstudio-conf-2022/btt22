#' Get available states
#'
#' Returns all available states of ussie.
#'
#' @param pattern `character` regular expression, used to filter
#'  candidate-states. Default specifies name has to start with a `1` or `2`,
#'  followed by a dot (`.`).
#'
#' @return `character` vector of all available states.
#' @examples
#' btt_state()
#' @export
#'
btt_state <- function(pattern = "^[12]\\.") {
  branch_list <-  gert::git_branch_list(repo = path_repo())

  candidates <-
    branch_list$name %>%
    strsplit("/") %>%                      # split (used for remotes)
    vapply(\(x) utils::tail(x, 1), "") %>% # get last entry for each
    unique()

  # return only those candidates that satisfy the regex
  result <- candidates[grepl(pattern, candidates)]

  result
}
