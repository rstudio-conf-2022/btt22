# throws an error if:
#  - not called from a package directory
#  - that package is not called "ussie"
#
# if happy, returns an rprojroot criterion, invisibly
#   - e.g.: use `root$find_file()` to form path within directory
#
validate_package_name <- function(name) {

  root <- rprojroot::is_r_package

  desc_file <-
    tryCatch(
      root$find_file("DESCRIPTION"),
      error = function(e) {
        cli::cli_abort(
          c(
            "Must be run from a package directory.",
            i = "Current directory: {.file {getwd()}}"
          ),
          class = "btt22_package_directory",
          cwd = getwd(),
          call = rlang::caller_env()
        )
      }
    )

  package_name <- desc::desc_get_field("Package", file = desc_file)
  if (!identical(package_name, name)) {
    cli::cli_abort(
      c(
        "Package must be named {.val {name}}.",
        i = "Name of package in current directory: {.val {package_name}}"
      ),
      class = "btt22_package_name",
      package_name = package_name,
      call = rlang::caller_env()
    )
  }

  invisible(root)
}

validate_state <- function(state) {
  states_available <- btt_state()
  if (!state %in% states_available) {
    cli::cli_abort(
      c(
        "State requested is not available.",
        i = "State requested: {.val {state}}",
        i = "States available: {.val {states_available}}"
      ),
      class = "btt22_state",
      state = state,
      states_available = states_available,
      call = rlang::caller_env()
    )
  }

  invisible(state)
}
