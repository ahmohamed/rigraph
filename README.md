
<!-- badges: start -->
![R-CMD-check](https://github.com/igraph/rigraph/workflows/R-CMD-check/badge.svg)
![CRAN Downloads](https://cranlogs.r-pkg.org/badges/igraph)
<!-- badges: end -->

# R/igraph

R/igraph is an R package of the igraph network analysis library.

## Installation

You can install the stable version of R/igraph from CRAN:

```r
install.packages("igraph")
```

For the development version, you can use R-universe

```r
options(
  repos = c(
    igraph = 'https://igraph.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'
  )
)
install.packages('igraph')
```

or Github, with the `devtools` package:

```r
devtools::install_github("igraph/rigraph")
```

For installation from source on Windows, you need to have
[RTools](https://cran.r-project.org/bin/windows/Rtools/) installed.
Additionally, the three system requirements of `glpk`, `libxml2` and `gmp` are
not optional, but hard requirements. For versions R >= 4.0 you can install these
using

```
pacman -Sy mingw-w64-{i686,x86_64}-glpk mingw-w64-{i686,x86_64}-libxml2 mingw-w64-{i686,x86_64}-gmp
```

See the package wiki for more information on [installation troubleshooting](https://igraph.github.io/rigraph/articles/installation-troubleshooting).

## Documentation

See the [igraph homepage](https://igraph.org/r/) for the complete manual.

## Contributions

Please read our
[contribution guide](https://github.com/igraph/rigraph/blob/dev/CONTRIBUTING.md).

## License

GNU GPL version 2 or later
