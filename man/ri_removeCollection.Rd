% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ri_removeCollection.R
\name{ri_removeCollection}
\alias{ri_removeCollection}
\title{Removes a iRODS collection}
\usage{
ri_removeCollection(collection)
}
\arguments{
\item{collection}{name of the collection to remove}
}
\description{
This function removes an iRODS collection. The collection must be
empty. If the collection can not be removed, this function
generates an error.
}
