# internal data used in `path_repo()`
path_ussie <- NULL

.onLoad <- function(libname, pkgname) {

  # when local source is enabled, use it as default
  source <- getOption("btt22.source") %||% "remote"

  # make sure path is empty
  path_temp <- fs::path_temp("ussie")
  if (fs::dir_exists(path_temp)) {
    fs::dir_delete(path_temp)
  }

  if (identical(source, "remote")) {
    cli::cli_inform(c(i = "Retrieving ussie repo from remote"))
    gert::git_clone("https://github.com/rstudio-conf-2022/ussie", path = path_temp)
  } else {
    # idea - when we get close, put a tar.gz copy of ussie into `inst` so that
    # we can run locally if need be.
  }

  path_ussie <<- path_temp
}

.onUnload <- function(libpath) {
  fs::dir_delete(path_repo())
}
