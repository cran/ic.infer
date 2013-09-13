\name{contr.diff}
\alias{contr.diff}
\title{ Contrast function for factors with ordered values that yields increment coefficients }
\description{
Function \code{contr.diff} is a contrast function for factors with ordered values. 
Coefficients for factors formatted with \code{contr.diff} are the increments 
from the current level to the neighbouring lower level.
}
\usage{
contr.diff(n, contrasts = TRUE)
}
\arguments{
  \item{n}{ vector of levels or integer number of levels}
  \item{contrasts}{ logical indicating whether contrasts should be computed}
}
\details{
The design matrix for an ordered factor formatted with \code{contr.diff} consists of ones 
for the current level itself and all lower levels. Thus, the estimated coefficients 
for each level are the estimated differences to the next lower level. 

With this coding, the matrix \code{ui} in functions of package \pkg{ic.infer} 
can be chosen as the identity matrix for monotonicity constraints on the factor. 
}
\value{
  a matrix with a row for each level and a column for each dummy variable 
  (when applied to a factor in a linear model). 
  }
\author{ Ulrike Groemping, BHT Berlin }
\seealso{ See also \code{\link{ic.test}}, \code{\link{ic.est}}, 
         \code{\link{orlm}}, \code{\link[stats]{contrasts}} for other contrast 
         functions }
\examples{
## mu, Sigma and covariance matrix
means <- c(3,5,2,7)
## contrast matrix
contr.diff(4)
## design matrix
X <- cbind(rep(1,4),contr.diff(4))
## estimated coefficients
solve(t(X)\%*\%X,t(X)\%*\%means)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ multivariate }
\keyword{ optimize }
