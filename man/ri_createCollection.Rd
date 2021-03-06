% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ri_createCollection.R
\name{ri_createCollection}
\alias{ri_createCollection}
\title{Create a new IRODS collection}
\usage{
ri_createCollection(collection)
}
\arguments{
\item{collection}{path of new collection}
}
\value{
nothing
}
\description{
This function creates a new collection in iRODS. The collection
must be provided with the full path. If the collection can't be
created, this function generates an error.
}
