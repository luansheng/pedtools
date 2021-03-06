% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ped_accessors.R
\name{getSex}
\alias{getSex}
\alias{swapSex}
\title{Get or modify pedigree genders}
\usage{
getSex(x, ids = labels(x))

swapSex(x, ids, verbose = TRUE)
}
\arguments{
\item{x}{A \code{ped} object.}

\item{ids}{A character vector (or coercible to one) containing ID labels.}

\item{verbose}{A logical: Verbose output or not.}
}
\value{
\itemize{
\item \code{getSex()} returns an integer vector of the same length as \code{ids}, with
entries 0 (unknown), 1 (male) or 2 (female).
\item \code{swapSex()} returns a \code{ped} object similar to the input, but where the
gender codes of \code{ids} (and their spouses) are swapped (1 <->
2).
}
}
\description{
Functions for retrieving or changing the gender codes of specified pedigree
members.
}
\examples{
x = nuclearPed(1)
stopifnot(all(getSex(x) == c(1,2,1)))

swapSex(x, 3)

}
\seealso{
\code{\link[=ped]{ped()}}
}
