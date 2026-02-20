# View and delete cached files

View and delete cached files

Show the files you have in your cache

## Usage

``` r
delete_cache(files_to_delete = NULL)

show_cached_files()
```

## Arguments

- files_to_delete:

  An optional argument to specify which files or layers should be
  deleted from the cache. Defaults to deleting all files pausing for
  permission from user. If a subset of files are specified, the files
  are immediately deleted.

## Value

`delete_cache()`: A logical of whether the file(s) were successful
deleted

`show_cached_files()`: a data.frame with the columns:

- `file`, the name of the file,

- `size_MB`, file size in MB,

- `is_dir`, is it a directory? If you have cached tiles from the
  [`cded()`](http://bcgov.github.io/bcmaps/dev/reference/cded.md)
  functions, there will be a row in the data frame showing the total
  size of the cded tiles cache directory.

- `modified`, date and time last modified

## Examples

``` r
if (FALSE) { # \dontrun{
## See which files you have
show_cached_files()

## Delete your whole cache
delete_cache()

## Specify which files are deleted
delete_cache(c('regional_districts.rds', 'bc_cities.rds'))
} # }
```
