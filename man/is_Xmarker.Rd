% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/marker_utils.R
\name{is_Xmarker}
\alias{is_Xmarker}
\title{Test if a marker is on the X chromosome}
\usage{
is_Xmarker(x)
}
\arguments{
\item{x}{A marker object. (If \code{x} is not a marker object, the function
returns FALSE.)}
}
\value{
TRUE or FALSE.
}
\description{
Tests if the \code{chrom} attribute of a marker is 23.
}
