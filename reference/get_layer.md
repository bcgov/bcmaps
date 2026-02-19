# Get a B.C. spatial layer

Get a B.C. spatial layer

## Usage

``` r
get_layer(layer, ask = interactive(), force = FALSE)
```

## Arguments

- layer:

  the name of the layer. The list of available layers can be obtained by
  running
  [`available_layers()`](http://bcgov.github.io/bcmaps/reference/available_layers.md)

- ask:

  Should the function ask the user before downloading the data to a
  cache? Defaults to the value of interactive().

- force:

  Should you force download the data?

## Value

the layer requested

## Examples

``` r
if (FALSE) { # \dontrun{
 get_layer("bc_bound_hres")
} # }
```
