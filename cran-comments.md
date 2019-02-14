## Test environments

* local OS X install (Mojave), R 3.5.2
* local Windows 10, R 3.5.2
* ubuntu 14.04 (on travis-ci): R 3.5.2 and R-devel (2019-02-01 r76041)
* win-builder (R-devel)

## R CMD check results

There were no ERRORS or WARNINGS

* There were 2 NOTEs:

1. Suggests or Enhances not in mainstream repositories:
     bcmapsdata
   Availability using Additional_repositories specification:
     bcmapsdata   yes   https://bcgov.github.io/drat
     
2. Packages suggested but not available for checking: 
      'bcmapsdata' 'doMC' (Windows)
    
- 'bcmapsdata' - A suggested package that is in a non-mainstream repository (a drat repository).
- 'doMC' - Package not available for Windows

## Reverse dependencies

There are no reverse dependencies.
