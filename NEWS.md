# btt22 0.0.0.9000

* Automatic loading and unloading of ussie repo. (#3)

  - Added `.onLoad()`, `.unLoad()` functions so that ussie repo placed a temporary directory.
    Currently, this package downloads the ussie repo from GitHub each time it loads; once the ussie branches are stable, we can include an `ussie.tar.gz` in the `inst` folder of this package. 

  - Added internal function `path_repo()`, returns (temporary) path to ussie repo.

* Added a `NEWS.md` file to track changes to the package.
