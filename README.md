
<!-- README.md is generated from README.Rmd. Please edit that file -->

# btt22

<!-- badges: start -->

[![R-CMD-check](https://github.com/ijlyttle/btt22/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ijlyttle/btt22/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of btt22 is to help you build the
[**ussie**](https://github.com/ijlyttle/ussie) package during the
[Building Tidy Tools
2022](https://github.com/rstudio-conf-2022/build-tidy-tools) workshop.

The central project for this course is that each student will build a
package called {ussie}, and populate it with functions.

There are two big purposes for this package:

-   if you install this package, and update all of its dependencies, you
    will have all the packages you need for this course.
-   you can use the functions from this package to import code:
    -   `btt_state()`: list all the available states. A state has an
        identifier like `"2.1.1"`: day `2`, session `1`, task `1`. This
        identifier corresponds to a [branch in the {ussie}
        repository](https://github.com/ijlyttle/ussie/branches).
    -   `btt_get(state)`:
        -   gets the skeleton code to be used for the given `state`
        -   puts it into your package’s `R` folder or `tests/testthat`
            folder.
    -   `btt_reset_hard(state)`: this is the “in case of emergency,
        break glass” function. According to the `state`, it rewrites
        your package’s :
        -   `R` folder
        -   `tests/testthat` folder
        -   `DESCRIPTION` file: `Imports` and `Suggests` sections

## Installation

You can install the development version of btt22 like so:

``` r
# install.packages("devtools")
devtools::install_github("ijlyttle/btt22")
```

## Examples

Here’s how to get the available states (there will be more states
available soon!):

``` r
library(btt22)
btt_state()
#> [1] "2.1.1" "2.1.2" "2.2.1"
```

Let’s say we are at the start of the second session of day 2 - this
corresponds to state `"2.2.1"`.

Let’s say that you, dear student, are on the happy path. In this case,
to get the templated code for this task, you would:

``` r
btt_get("2.2.1")
```

Let’s say that you are *not* on the happy path and that the best course
of action is just to catch-up. In this case, to get the completed code,
you would:

``` r
btt_reset_hard("2.2.1")
```

Then you could use `btt_get("2.2.1")` to get the templated code beacuse
you would now be on the the happy path.

To avoid inadvertent chaos, `btt_get()` and `btt_reset_hard()` make a
couple of checks before it writes anything to your project:

-   is your working directory in a package?
-   is this package called `"ussie"`?
