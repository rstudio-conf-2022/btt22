# btt22 0.0.0.9000

* Added function to reset state of ussie, `btt_reset()`. (#5)

  - Must be run from directory within an R package called **ussie**.
  - Given a `state` (get available states using `btt_state()`), completely overwrites:
    - `R` directory
    - `tests` directory
    - `Imports` and `Suggests` fields in `DESCRIPTION` file

* Automatic loading and unloading of ussie repo. (#3)

  - Added `.onLoad()`, `.unLoad()` functions so that ussie repo placed a temporary directory.
    Currently, this package downloads the ussie repo from GitHub each time it loads; once the ussie branches are stable, we can include an `ussie.tar.gz` in the `inst` folder of this package. 

  - Added internal function `path_repo()`, returns (temporary) path to ussie repo on in user's temp directory.

* Added a `NEWS.md` file to track changes to the package.
