## Test environments

* local OS X install, R 3.4.3
* local Windows 7, R 3.4.3
* ubuntu 14.04 (on travis-ci), R 3.4.3
* win-builder (R-devel)
* Debian Linux, R-patched, GCC (on R-Hub)

## R CMD check results

There were no ERRORS or WARNINGS

* There was 1 NOTE:
    "Packages suggested but not available for checking: 'bcmaps.rdata' 'doMC'"
    - 'bcmaps.rdata' - A suggested package that is in a non-mainstream repository (a drat repository).
    - 'doMC' - Package not available for Windows

## Reverse dependencies

There are no reverse dependencies.
