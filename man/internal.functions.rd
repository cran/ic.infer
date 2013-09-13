\name{internal.functions}
\alias{nchoosek}
\alias{GaussianElimination}
\alias{RREF}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ internal functions not intended for the user }
\description{
nchoosek is originally taken from package vsn by Wolfgang Huber,
GaussianElimination and RREF have been provided by John Fox in R-help and
have been modified by the author to provide more output}
\usage{
nchoosek(n, k)    ## not exported, calculates all combinations
GaussianElimination(A, B, tol=sqrt(.Machine$double.eps),
    verbose=FALSE)   ## not exported
RREF(X, ...)    ## not exported, calculates reduced Echelon form
}
\arguments{
  \item{n}{ number of elements to choose from }
  \item{k}{ number of elements to choose }
  \item{A}{ argument to \code{GaussianElimination} }
  \item{B}{ argument to \code{GaussianElimination} }
  \item{tol}{ argument to \code{GaussianElimination} }
  \item{verbose}{ argument to \code{GaussianElimination} }
  \item{X}{ matrix to be reduced to reduced Echelon form }
  \item{\dots}{ further arguments to \code{GaussianElimination} }
  }

\value{
  \code{nchoosek} returns all subsets of size \code{k}, 
  for \code{GaussianElimination} and \code{RREF} cf. comments in code. 
  The latter are used for reducing a matrix with less than full row rank
  to a set of linearly independent rows.
  }
\author{ Ulrike Groemping, BHT Berlin, 
based on code by John Fox and Wolfgang Huber }
\seealso{ \code{\link{ic.test}}, \code{\link{orlm}} }
\examples{
z <- 0.5
corr <- matrix(c(1,0.9,0.9,1),2,2)
print(wt.plus <- ic.weights(corr))
T <- c(z,z)%*%solve(corr,c(z,z))
1-pchibar(T,2:0,wt.plus)
1-pbetabar(T/(T+10),2:0,10,wt.plus)
corr <- matrix(c(1,0,0,1),2,2)
print(wt.0 <- ic.weights(corr))
T <- c(z,z)%*%solve(corr,c(z,z))
1-pchibar(T,2:0,wt.0)
1-pbetabar(T/(T+10),2:0,10,wt.0)
corr <- matrix(c(1,-0.9,-0.9,1),2,2)
print(wt.minus <- ic.weights(corr))
T <- c(z,z)%*%solve(corr,c(z,z))
1-pchibar(T,2:0,wt.minus)
1-pbetabar(T/(T+10),2:0,10,wt.minus)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ multivariate }
