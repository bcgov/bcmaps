## CRAN check issues

* Fixed failure with a GEOS system library with non-numeric version components (e.g. GEOS 3.9.0dev) - this was occurring on new M1 Mac checks on CRAN, though it was also reported as an issue (https://github.com/bcgov/bcmaps/issues/71).

## Test environments

* local OS X install (Mojave), R 4.0.2
* ubuntu 18.04 (on GitHub Actions): R 3.5, R 3.6.3, R 4.0.3, and R-devel (2021-01-04 r79789)
* Windows Server 2019 (on GitHub Actions), R 4.0.3
* macOS Catalina 10.15 (on GitHub Actions), R 4.0.3
* win-builder (R-devel)

## R CMD check results

There were no ERRORS, WARNINGS, or NOTES

## Reverse dependencies

There are no reverse dependencies.
