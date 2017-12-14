## Test environments
* local OS X install, R 3.4.3
* ubuntu 14.04 (on travis-ci), R 3.4.3
* win-builder (devel and release)
* Debian Linux, R-patched, GCC (on R-Hub)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new submission.

On win-builder, there was one additional NOTE: 
    "Packages suggested but not available for checking: 'bcmaps.rdata' 'doMC'"
    - bcmaps.rdata - a package containing data that is used by bcmaps - It is hosted for installation at: https://bcgov.github.io/drat.
    - doMC - Not available for Windows

## Reverse dependencies

This is a new release, so there are no reverse dependencies.
