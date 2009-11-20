\name{ic.infer}
\alias{ic.infer-package}
\title{ Package for inequality-constrained estimation and testing }
\description{
Package \code{ic.infer} implements estimation and testing for multivariate normal 
expectations with linear equality- and inequality constraints. This also includes 
inference on linear models with linear equality- and inequality constraints on the 
parameters. Decomposition of R-squared is also included for these models.
}

\details{
Function \code{ic.est} estimates the constrained expectation of a multivariate normal 
random vector, function \code{ic.test} conducts related tests. 

Function \code{orlm} estimates constrained parameters in normal linear models based on 
a linear model object or a covariance matrix. The function offers the possibility of 
bootstrapping the estimates. Tests and confidence intervals are provided by a summary 
function. 

Function \code{or.relimp} decomposes the $R^2$-values analogously to metric 
\code{lmg} in package \pkg{relaimpo} for unconstrained linear models. 
However, \code{or.relimp} is far less comfortable 
to use und subject to severe limitations, since automatic selection of restrictions 
for sub models is not in all cases trivial. 

The package makes use of various other R packages: \pkg{quadprog} is used for 
constrained estimation, \pkg{mvtnorm} in calculation of weights for null distributions 
of test statistics, \pkg{kappalab} for averaging over orderings in function \code{or.relimp}, 
and \pkg{boot} for bootstrapping.
}

\value{
  The output of function \code{ic.est} belongs to S3 class \code{orest}. 
  
  The output of function \code{ic.test} belongs to S3 class \code{ict}. 
  
  The output of function \code{orlm} belongs to S3 classes \code{orlm} and \code{orest}. 
  
  All these classes offer print and summary methods. 
  
  The output of function \code{or.relimp} is a named vector. }
  
\section{Acknowledgements}{
  This package uses as an internal function the function \code{nchoosek} from \pkg{vsn}, 
  authored by Wolfgang Huber, available under LGPL.
  
  It also uses modifications of numerical routines that were provided by John Fox 
  in R-help.
  
  Thanks go to Wiley for permission of incorporating the grades data 
  from Table 1.3.1 of Robertson, Wright and Dykstra (1988) into the package.
  }
\examples{
## unrestricted linear model for grade point averages
limo <- lm(meanGPA~.-n, weights=n, data=grades)
summary(limo)
## restricted linear model with restrictions that better HSR ranking 
## cannot deteriorate meanGPA
orlimo <- orlm(lm(meanGPA~.-n, weights=n, data=grades), index=2:9, 
       ui=make.mon.ui(grades$HSR))
summary(orlimo, brief=TRUE)
}
\references{
    Kudo, A. (1963) A multivariate analogue of the one-sided test. 
    \emph{Biometrika} \bold{50}, 403--418
    
    Robertson T, Wright F, Dykstra R (1988). \emph{Order-Restricted Inference}. 
    Wiley, New York.

    Sasabuchi, S. (1980) A test of a multivariate normal mean with composite 
       hypotheses determined by linear inequalities. \emph{Biometrika} 
       \bold{67}, 429--429
       
    Shapiro, A. (1988) Towards a unified theory of inequality-constrained 
    testing in multivariate analysis. \emph{International Statistical Review} 
    \bold{56}, 49--62
    
    Silvapulle, M.J. and Sen, P.K. (2004) \emph{Constrained Statistical Inference}. 
    Wiley, New York}
\author{ Ulrike Groemping, BHT Berlin }
\seealso{ See also \code{\link{ic.est}}, \code{\link{ic.test}}, \code{\link{orlm}},
        \code{\link{or.relimp}}, packages \pkg{boot}, \pkg{kappalab}, 
        \pkg{mvtnorm}, \pkg{quadprog}, and \pkg{relaimpo}}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ htest }
\keyword{ models }
\keyword{ regression }
\keyword{ multivariate }
