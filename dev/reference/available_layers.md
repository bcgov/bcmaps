# List available data layers

A data.frame of all available layers in the bcmaps package. This drawn
directly from the B.C. Data Catalogue and will therefore be the most
current list layers available.

## Usage

``` r
available_layers()
```

## Value

A `data.frame` of layers, with titles, and a `shortcut_function` column
denoting whether or not a shortcut function exists that can be used to
return the layer. If `TRUE`, the name of the shortcut function is the
same as the `layer_name`. A value of `FALSE` in this column means the
layer is available via `get_data()` but there is no shortcut function
for it.

A value of `FALSE` in the `local` column means that the layer is not
stored in the bcmaps package but will be downloaded from the internet
and cached on your hard drive.

## Examples

``` r
if (FALSE) { # \dontrun{
available_layers()
} # }
```
