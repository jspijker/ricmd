# ricmd

R package for iRODS icommands. This [R](https://r-project.org) package
is an interface between R and [iRODS](https://irods.org) the integrated
Rule Oriented Data System.

## Features

This package tries to implement the core functionality to work with
iRODS collections from within R.

With this package you can:
 - Connect to an iRODS Zone
 - Create and remove collections 
 - store and retrieve data from a collection
 - add and remove meta data from data objects

# Release

The current release is version 1.0.0. Version numbers follow the
major.minor.patch versioning system.

# Development version

This package is stil under development and new features will be added
in the future.  For example meta data management for collections
and search queries on meta data are anticipated.

latest features can be found in the development branch of this
packge.

# Install

This package is not (yet) available on CRAN, you can install it
directly from GitHub:

```r
remotes::install_github("jspijker/ricmd",build_vignettes=TRUE)
```

To read the vignette:

```r
vignette("ricmd")
```

# licence

This package is publicly available under the [GPL 3.0
licence](https://www.gnu.org/licenses/gpl-3.0.en.html),
please see accompanying [LICENCE
file](https://github.com/jspijker/ricmd/blob/master/LICENSE). 
