# btt22 0.0.0.9000

* Imports {devtools}, {diffviewer}, {dplyr}, {engsoccerdata}, {ggplot2}, and {shiny}, so that installing this package will get you all the packages you will need for the course. (#15)

* Renamed `btt_reset()` to `btt_reset_hard()`. (#12)

* Added function to get new files for state of ussie, `btt_get()`. (#7)

  - Must be run from directory within an R package called **ussie**.

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
