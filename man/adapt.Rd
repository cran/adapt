\name{adapt}
\title{Adaptive Integration in 2--20 Dimensions.}
\usage{
adapt(ndim, lower, upper, minpts, maxpts, functn, eps,\dots)
}
\alias{adapt}
\alias{print.integration}
\description{
    \code{adapt()} integrates a scalar function over a multidimensional
rectangle, ie computes	
    \deqn{\int_l^u \mbox{functn}(t)\,d^nt}{integral[l .. u] functn(t)
d^n(t)}
    where \eqn{l =}\code{lower}, \eqn{u =}\code{upper}, \eqn{n
=}\code{ndim}. Infinite rectangles are not allowed, and \code{ndim} must
be between 2 and 20.
 
}
\arguments{
\item{ndim}{the number of dimensions of the function/integral}
\item{lower}{vector of at least length ndim of the lower bounds on the integral}
\item{upper}{vector of at least length ndim of the upper bounds on the integral}
\item{minpts}{the minimum number of function evaluations}
\item{maxpts}{the maximum number of function evaluations or NULL }
\item{functn}{the name of an \R function.
    \code{functn} should take a single vector
    argument and possibly some parameters and return the function value at
    that point.  \code{functn} must return a single numeric value.}
\item{eps}{The desired accuracy for the relative error.}
\item{\dots}{Other parameters to be passed to \code{functn}}
}
\value{
A list of \code{\link{class} "integration"} with components
\item{value}{the estimated integral}
\item{relerr}{the estimated relative error; \code{< eps} argument if}
\item{minpts}{the actual number of function evaluations}
\item{ifail}{an error indicator.  If ifail is not equal to 0, the function
    warns the user of the error condition.}
}
\details{This is modified from Mike Meyer's S code. The functions just
call A.C. Genz's fortran ADAPT subroutine to do all of the
calculations.  A work array is allocated within the C/Fortran code. 

The Fortran function has been modified to use double precision, for
compatibility with \R. It only works in two or more dimensions; for
one-dimensional integrals use the \code{\link{integrate}} function in base
R.

Setting maxpts to NULL asks the function to keep doubling maxpts (starting at
\code{max(minpts,500)}) until the desired precision is achieved or R runs out of memory.
}

\seealso{\code{\link{integrate}}}
\examples{
## Example of a three dimensional spherical normal distribution:
ir2pi <- 1/sqrt(2*pi)
fred <- function(z) { ir2pi^length(z) * exp(-0.5 * sum(z * z))}
## not enough evaluations
adapt(3, c(-2,-2,-2),c(2,2,2),100,300,fred,.01)
## enough evaluations
adapt(3, c(-2,-2,-2),c(2,2,2),100,600,fred,.01) 
## no upper limit 
## this took 7465 points, ie 5 attempts (on an Athlon/gcc/g77)
adapt(3, c(-2,-2,-2),c(2,2,2),100,NULL,fred,.00001)
}
\keyword{math}
\keyword{utilities}

