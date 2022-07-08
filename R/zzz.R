# internal data used in `path_repo()`
path_ussie <- NULL

.onLoad <- function(libname, pkgname) {

  source <- getOption("btt22.source") %||% "local"

  # make sure path is empty
  path_temp <- fs::path_temp("ussie")
  if (fs::dir_exists(path_temp)) {
    fs::dir_delete(path_temp)
  }

  if (identical(source, "remote")) {
    cli::cli_inform(
      c(i = "Retrieving ussie repo from remote source: {.url {url_ussie()}}")
    )
    gert::git_clone(url_ussie(), path = path_temp)
  } else {
    # use local copy of ussie
    zip::unzip(
      zipfile = system.file("ussie-repo/ussie.zip", package = "btt22"),
      exdir = path_temp
    )
  }

  if (!has_base_pipe()) {
    message_base_pipe()
  }

  path_ussie <<- path_temp
}

.onUnload <- function(libpath) {
  fs::dir_delete(path_repo())
}

has_base_pipe <- function() {

  version <- as.character(utils::packageVersion("base"))

  utils::compareVersion(version, "4.1.0") >= 0
}

message_base_pipe <- function() {
  cli::cli_alert_warning(
    "Your version of R does not have the base pipe: {.code |>}"
  )

  cli::cli_alert_info(
    "Replace all instances of {.code |>} with {.code %>%}"
  )
}
