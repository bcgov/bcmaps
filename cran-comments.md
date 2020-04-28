## Resubmission
This is a resubmission. In this version I have:

* Fixed/removed invalid URLs in README.md

## CRAN check issues

* This is a submission for bcmaps which was archived on 2020-04-27 due to failing
checks on CRAN

* Fixed CRAN errors that were occurring on most check platforms (eg https://www.r-project.org/nosvn/R.check/r-release-linux-x86_64/bcmaps-00check.html). 
`st_make_valid()`, previously exported from package `lwgeom` is now exported from `sf` 
and its use is dependent on the version of `GEOS` upon which `sf` was built.
I have made the use of `st_make_valid()` conditional upon these factors.

## Test environments

* local OS X install (Mojave), R 3.6.2
* ubuntu 16.04 (on GitHub Actions): R 3.5 and R 4.0
* Windows Server 2019 (on github actions), R 4.0
* macOS Catalina 10.15 (on github actions), R 3.6.3 and R-devel (2020-04-21 r78269)

## R CMD check results

There were no ERRORS or WARNINGS

* There was 1 NOTE:

1. Suggests or Enhances not in mainstream repositories:
     bcmapsdata
   Availability using Additional_repositories specification:
     bcmapsdata   yes   https://bcgov.github.io/drat

- 'bcmapsdata' - A suggested package that is in a non-mainstream repository (a drat repository).

## Reverse dependencies

There are no reverse dependencies.
