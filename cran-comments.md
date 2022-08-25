## Release summary

This is a patch release, primarily to address changes in the raster package that were causing test failures in this package.

### CRAN check issues

All CRAN check issues have been fixed - previous tests compared both order and values of a return value to an expected result. Changes in raster made the order unreliable, so we now only test the value.

## R CMD check results

There were no ERRORS, WARNINGS, or NOTEs.

## Reverse dependencies

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
