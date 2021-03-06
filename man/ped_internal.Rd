% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ped_internal.R
\name{ped_internal}
\alias{ped_internal}
\alias{reorderPed}
\alias{parents_before_children}
\alias{has_parents_before_children}
\alias{internalID}
\title{Internal ordering of pedigree members}
\usage{
reorderPed(x, neworder = order(labels(x)))

parents_before_children(x)

has_parents_before_children(x)

internalID(x, ids)
}
\arguments{
\item{x}{A \code{ped} object}

\item{neworder}{A permutation of \code{labels(x)} or of vector \code{1:pedsize(x)}. By
default, the sorting order of the ID labels is used.}

\item{ids}{A character vector (or coercible to one) of original ID labels.}
}
\description{
These functions give access to - and enable modifications of - the order in
which the members of a pedigree are stored. (This is the order in which the
members are listed when a \code{ped} object is printed to the screen.)
}
\details{
The internal ordering is usually of little importance for end users, with one
important exception: Certain pedigree-traversing algorithms require parents
to precede their children. A special function, \code{parents_before_children()} is
provided for this purpose. This is a wrapper of the more general
\code{reorderPed()} which allows any permutation of the members.

It should be noted that \code{\link[=ped]{ped()}} by default calls \code{parents_before_children()}
whenever a pedigree is created, unless explicitly avoided with
\code{reorder=FALSE}.

\code{has_parents_before_children()} can be used as a quick test to decide if it
is neccessary to call \code{parents_before_children()}.

The utility \code{internalID()} converts ID labels to indices in the internal
ordering.
}
\examples{
x = ped(id = 3:1, fid = c(1,0,0), mid = c(2,0,0), sex = c(1,2,1), reorder = FALSE)
x

# The 'ids' argument is converted to character
internalID(x, ids = 3)
internalID(x, ids = "3")

y = parents_before_children(x)
internalID(y, ids = 3)

# A different ordering
reorderPed(x, c(2,1,3))

}
\seealso{
\code{\link[=ped]{ped()}}
}
