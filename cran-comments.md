## Release summary

This release is in response to a CRAN request to remove the indirect
dependency on `leaflet.extras`, which is scheduled for archival on 2026-02-19.
We bumped the minimum version of `bcdata` to ensure no dependency chain to
`leaflet.extras`.

## R CMD check results

There were no ERRORs, WARNINGs, or NOTEs.

## revdepcheck results

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
