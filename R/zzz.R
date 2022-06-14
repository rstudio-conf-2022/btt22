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

  path_ussie <<- path_temp
}

.onUnload <- function(libpath) {
  fs::dir_delete(path_repo())
}
