# btt22 0.0.6

* Remove base pipe so that folks with R v3 can still use. 
  Generates startup message in case base pipe is not available. (#24)

# btt22 0.0.5

* Various updates to ussie repo.

# btt22 0.0.2

* Added {palmerpenguins}. (#22)

* Improved user-interface to `btt_get()`. (#17)

  - Lists files to be copied into the package directory.
  - Opens the files for interactive editing (use `open` argument to change).
  - Uses updated structure for template files in {ussie}; old version of {btt22}
    will not work with new version of {ussie}.

# btt22 0.0.1

* Updated to reflect new home at rstudio-conf-2022. 
  Removed vignettes, as we can handle everything in the README. (#1, #4)

* This package keeps a copy of the {ussie} repo. (#11)

  - Added option `"btt22.source"` to use `"local"` (default) or `"remote"` source for {ussie}. 
  - For instructors, added unexported function, `btt_update_ussie()`:
    - puts latest copy of ussie repo, as a `.zip` file, into `/inst/ussie-repo/`
    - bumps the (patch) version of this package

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
