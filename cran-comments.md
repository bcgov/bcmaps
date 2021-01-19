## CRAN check issues

* Fixed WARNING on r-oldrel-MacOS where vignette building failed. This was due 
to bundled `sf` data having CRS attributes incompatible with the older GDAL/PROJ system
libraries on that particular check machine. This is fixed by generating the CRS of bundled
data when they are loaded, using the installed GDAL/PROJ stack.

* bcmaps is now using `tools::R_user_dir("bcmaps", "cache")` to store cached data on R >=
4.0, and `rappdirs::user_cache_dir("bcmaps")` otherwise, to comply with CRAN policy.
Data are only cached when the user consents, and users can remove all or a selection of the 
cached data with the `bcmaps::delete_cache` function.

## Test environments

* local OS X install (Mojave), R 4.0.2
* ubuntu 18.04 (on GitHub Actions): R 3.5, R 3.6.3, R 4.0.3, and R-devel (2021-01-17 r79842)
* Windows Server 2019 (on GitHub Actions), R 4.0.3
* macOS Catalina 10.15 (on GitHub Actions), R 4.0.3
* win-builder (R-devel 2021-01-18 r79846)

## R CMD check results

There were no ERRORS, WARNINGS, or NOTEs.

## Reverse dependencies

There are no reverse dependencies.
