# internal data used in `path_repo()`
path_ussie <- NULL

.onLoad <- function(libname, pkgname) {

  # make sure path is empty
  path_temp <- fs::path_temp("ussie")
  if (fs::dir_exists(path_temp)) {
    fs::dir_delete(path_temp)
  }

  # idea - when we get close, put a tar.gz copy of ussie into `inst` so that
  # we can run locally if need be.
  gert::git_clone("https://github.com/ijlyttle/ussie", path = path_temp)

  path_ussie <<- path_temp
}

.onUnload <- function(libpath) {
  fs::dir_delete(path_repo())
}
