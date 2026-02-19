# Biogeoclimatic Zone Colours

Standard colours used to represent Biogeoclimatic Zone colours to be
used in plotting.

## Usage

``` r
bec_colours()

bec_colors()
```

## Value

named vector of hexadecimal colour codes. Names are standard
abbreviations of Zone names.

## Examples

``` r
if (FALSE) { # \dontrun{
if (require(sf) && require(ggplot2)) {
 bec <- bec()
 ggplot() +
   geom_sf(data = bec[bec$ZONE %in% c("BG", "PP"),],
           aes(fill = ZONE, col = ZONE)) +
   scale_fill_manual(values = bec_colors()) +
   scale_colour_manual(values = bec_colours())
}
} # }
```
