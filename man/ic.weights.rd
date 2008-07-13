\name{ic.weights}
\alias{ic.weights}
\alias{pbetabar}
\alias{pchibar}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ functions for calculating the distributions of normal distribution 
        order-related likelihood ratio tests }
\description{
Test statistics of normal distribution-based order-related likelihood ratio 
tests are often distributed as mixtures of chi-square or beta-distributions 
with different parameters. These functions determine the mixing weights and 
the cumulative distribution functions based on these.
They can be directly used and are called by function ic.test.
}
\usage{
ic.weights(corr, algorithm = GenzBretz())
pchibar(x, df, wt)
pbetabar(x, df1, df2, wt)
}
\arguments{
  \item{corr}{ \code{corr} is the correlation or covariance matrix 
              (or any multiple thereof) of the data or coefficients 
              for which weights are to be calculated }
  \item{algorithm}{ \code{algorithm} is the algorithm to be used by function 
              \code{pmvnorm} of package \code{mvtnorm} for calculating 
              multivariate normal rectangle probabilities; it is possible 
              to tune weight accuracy by modifying this parameter, 
              cf. help for \code{GenzBretz}}
  \item{x}{ \code{x} is the quantile for which the distribution function
             is to be calculated }
  \item{df}{ is the vector of the degrees of freedom for the chi-square 
             distributions that are mixed into the chibar-square-distribution 
             with the proportions given in \code{wt}
              }
  \item{wt}{ each element of \code{wt} is the mixing weight of the chi-square
             distribution with df as in the corresponding element of \code{df};
             such weights can be calculated with function \code{ic.weights}}
  \item{df1}{ vector of first parameters of the beta-distributions to be 
             mixed into the betabar-distribution }
  \item{df2}{ second parameter of the beta-distributions to be 
             mixed into the betabar-distribution; error degrees of freedom
             in the tests implemented for linear models in summary.orlm }
  }
\details{
Function \code{ic.weights} uses results by Kudo (1963) 
regarding the calculation of the weights. The weights are the probabilities that 
the projection along its covariance onto the non-negative orthant 
of a multivariate normal random vector with expectation 0 and 
correlation \code{corr} lies in faces of dimensions \code{nrow(corr):1} 
(in this order). It is known that these probabilities coincide with 
various other useful probabilities related to order-related hypothesis testing,
cf. e.g. Shapiro (1988). Calculation of the weights involves various calls 
to function \code{pmvnorm} from package \code{mvtnorm}.

Functions \code{pchibar} (taken from package ibdreg) and \code{pbetabar} 
calculate cumulative probabilities from mixtures of chi-square and 
beta-distributions, respectively. 
}
\value{
  \code{ic.weights} returns the vector of weights, 
  \code{pchibar} and \code{pchibar} return the cumulative probability of the 
  respective distribution. 
  Function \code{ic.weights} relies on package \pkg{mvtnorm} for determining 
  multivariate normal rectangle probabilities. Note that these calculations 
  involve Monte Carlo steps so that these weights are not completely repeatable.  
}
\references{ 
    Kudo, A. (1963) A multivariate analogue of the one-sided test. 
    \emph{Biometrika} \bold{50}, 403--418
    
    Shapiro, A. (1988) Towards a unified theory of inequality-constrained 
    testing in multivariate analysis. \emph{International Statistical Review} 
    \bold{56}, 49--62}
\author{ Ulrike Groemping, TFH Berlin }
\seealso{ \code{\link{ic.test}}, \code{\link{orlm}}, \code{pmvnorm}, 
         \code{GenzBretz} }
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
