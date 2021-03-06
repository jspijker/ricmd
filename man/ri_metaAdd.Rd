% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ri_metaAdd.R
\name{ri_metaAdd}
\alias{ri_metaAdd}
\title{Adds meta data (AVU triple) to iRODS data object}
\usage{
ri_metaAdd(
  object,
  attribute,
  value,
  collection = ri_getCollection(),
  units = NULL
)
}
\arguments{
\item{object}{name of data object}

\item{attribute}{name of attribute}

\item{value}{value of attribute}

\item{collection}{iRODS collection where data object resides. If no collection is provided, it uses the default collection.}

\item{units}{unit of attribute, will be NULL if not provided}
}
\value{
nothing
}
\description{
Adds meta data to an iRODS data object. Meta data consists of
attribute - value - unit triples (AVU triples). This function only
adds meta data to data objects. Adding meta data to collections,
users etc. is not (yet) possible.
}
\details{
iRODS uses AVU triples (attribute - value - unit) to store meta
data to data objects, collections users etc. This function can be
used to add meta data to data objects. The attribute
and value are obligatory. If no unit is provided, it defaults to
NULL.
An AVU triple must be an unique combination of attribute, value,
and unit. If two tripples have the same attribute, the value must
differ, or, if the tripples have the same attribute and value, then
the unit must differ.

If no collection argument is provided, the default collection is
assumed (see \code{\link{ri_setCollection}}). If the AVU tripple
allready exists,
it is not overwritten, since the meta data is allready added to the
object.
}
