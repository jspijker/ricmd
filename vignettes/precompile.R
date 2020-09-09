#Vignettes that depend on internet access have been precompiled:

library(knitr)
knit("vignettes/ricmd.Rmd.orig", "vignettes/ricmd.Rmd")

library(devtools)
build_vignettes()
