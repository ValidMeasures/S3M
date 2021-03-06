% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sampling.R
\name{create_sp_grid}
\alias{create_sp_grid}
\title{Function to create sampling grids as per CSAS or S3M specifications. This is
a wrapper function for \code{spsample()} function in \code{sp} package that
adds arguments needed to implement CSAS and S3M-specific sampling.}
\usage{
create_sp_grid(
  x,
  d = NULL,
  area = NULL,
  country = NULL,
  buffer = ifelse(!is.null(d), d, 0),
  n = NULL,
  n.factor = NULL,
  type = "s3m",
  fixed = FALSE
)
}
\arguments{
\item{x}{Spatial object to grid}

\item{d}{A numeric value for distance (in kilometres) of the maximum distance
of a village/community from a sampling point. Default is 10 kilometres.}

\item{area}{A numeric value for area (in square kilometres) of a hexagon in a
hexagonal grid defining the sampling spatial resolution}

\item{country}{Name of country where sampling area is located. This is used
to determine the appropriate UTM projection to transform \code{x}}

\item{buffer}{A numeric value for distance (in kilometres) to expand the
borders of the given spatial object \code{x}. Specifying \code{buffer}
corrects the behaviour of \code{spsample()} to limit selection of sampling
points well within the borders of \code{x} often leaving areas at or near
the border of \code{x} unsampled. Default is \code{d} (if specified)
otherwise defaults to 0 (no buffer).}

\item{n}{Approximate number of sampling points / clusters needed. Approximate
because \code{spsample()} does not always result in \code{n} grids. If
\code{n} is the minimum number of sampling points required, specify
\code{n.factor} to inflate \code{n} with to ensure required minimum. If
fixed \code{n} amount of sampling points needed, specify \code{fixed} to
TRUE and specify \code{n.factor} to inflate \code{n}.}

\item{n.factor}{Inflation factor for \code{n}. Default value is 0 (no inflation)
which produces approximate number of grids (i.e., more or less \code{n}).
If minimum number of sampling points required, specify \code{n.factor} to
increase \code{n} with to ensure that number of grids will be at least
\code{n}. If fixed number of sampling points required (i.e., exactly \code{n}),
specify \code{n.factor} to increase \code{n} with. Function will go
through repeat cycles of \code{spsample()} until \code{n} sampling
points are selected.}

\item{type}{A character value of either "csas" or "s3m" to specify type of
spatial sampling to perform. If \code{"csas"}, a systematically aligned
sampling is applied by passing the argument \code{type} \code{"regular"}
to \code{spsample}. If \code{"s3m"}, sampling on a hexagonal lattice is
applied by passing the argument \code{type} \code{"hexagonal"} to
\code{spsample}. Default is \code{"s3m"}.}

\item{fixed}{Logical. If TRUE, \code{n.factor} must be specified and function
will go through repeat cycles of \code{spsample()} until \code{n}
sampling points are selected. Default is FALSE.}
}
\value{
An object of SpatialPoints-class. The number of points is only
    guaranteed to equal \code{n} when sampling is done in a square box,
    i.e. (sample.Spatial). Otherwise, the obtained number of points will have
    expected value \code{n}.
}
\description{
Function to create sampling grids as per CSAS or S3M specifications. This is
a wrapper function for \code{spsample()} function in \code{sp} package that
adds arguments needed to implement CSAS and S3M-specific sampling.
}
\examples{
#

}
