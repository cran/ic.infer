\name{ic.est}
\alias{ic.est}
\alias{print.orest}
\alias{summary.orest}
\title{ Functions for order-restricted estimates and printing thereof }
\description{
Function ic.est estimates a mean vector under linear inequality constraints, 
functions print.orest and summary.orest provide printed results in different 
degrees of detail.
}
\usage{
ic.est(x, Sigma, ui, ci = NULL, index = 1:nrow(Sigma), meq = 0, 
            tol = sqrt(.Machine$double.eps))
\method{print}{orest}(x, digits = max(3, getOption("digits") - 3), scientific = FALSE, \dots)
\method{summary}{orest}(object, display.unrestr = FALSE, brief = FALSE, 
            digits = max(3, getOption("digits") - 3), scientific = FALSE, \dots)
}
\arguments{
  \item{x}{ for \code{ic.est}: unrestricted vector (e.g. mean of a sample of random vectors), 
            from which the expected value under linear inequality 
            (and perhaps equality) restrictions is to be estimated 
            
            for \code{print.orest}: object of class \code{orest} 
            (normally produced by \code{ic.est} or \code{orlm})}
  \item{object}{ for \code{summary.orest}: 
            object of class \code{orest} 
            (normally produced by \code{ic.est} or \code{orlm})}
  \item{Sigma}{ covariance or correlation matrix (or any multiple thereof) 
            of \code{x} }
  \item{ui}{ matrix (or vector in case of one single restriction only) 
             defining the left-hand side of the restriction 
               
               \code{ui\%*\%mu >= ci},
               
            where mu is the expectation vector of x;         
            the first few of these restrictions can be declared equality- instead
            of inequality restrictions (cf. argument \code{meq}); 
            if only part of the elements of mu are subject to restrictions, 
            the columns of ui can be restricted to these elements, if their 
            index numbers are provided in \code{index}
            
            Rows of \code{ui} must be linearly independent; 
            in case of linearly dependent rows the function gives an error 
            message with a hint which subset of rows is independent.
            Note that the restrictions must define a (possibly translated) cone,
            i.e. e.g. interval restrictions on a parameter are not permitted. }
  \item{ci}{ vector on the right-hand side of the restriction (cf. \code{ui}),
            defaults to a vector of zeroes }
  \item{index}{ index numbers of the components of mu, 
            which are subject to the specified constraints 
             as \code{ui\%*\%mu[index] >= ci} }
  \item{meq}{ integer number (default 0) giving the number of rows of ui that 
             are used for equality restrictions instead of inequality 
             restrictions. 
              }
  \item{tol}{numerical tolerance value; 
             estimates closer to 0 than tol are set to exactly 0}
  \item{digits}{ number of digits to be used in printing }
  \item{scientific}{ if \code{FALSE}, suppresses scientific representation of 
              numbers (default: \code{FALSE}) }
  \item{\dots}{ further arguments to \code{print} }
  \item{display.unrestr}{ if TRUE, unrestricted estimate (i.e. \code{object}) is also displayed }
  \item{brief}{ if \code{TRUE}, suppress printing of restrictions; 
       default: \code{FALSE}}
}
\details{
Function \code{ic.est} heavily relies on package \pkg{quadprog} for determining 
the optimizer. It is a convenience wrapper for \code{solve.QP} from that package. 
The function is guaranteed to work appropriately if the specified restrictions 
determine a (translated) cone.  In that case, the estimate is the projection along 
matrix \code{Sigma} onto one of the faces of that cone (including the interior 
as the face of the highest dimension); this means that it minimizes the 
quadratic form \code{t(x-b)\%*\%solve(Sigma,x-b)} among all b that satisfy the 
restrictions \code{ui\%*\%b>=ci} (or, if specified by \code{meq}, 
with the first \code{meq} restrictions equality instead of inequality restrictions). 
}
\value{
  Function \code{ic.est} outputs a list with the following elements:
  \item{b.unrestr }{x}
  \item{b.restr }{restricted estimate}
  \item{Sigma}{ as input }
  \item{ui}{ as input}
  \item{ci}{ as input}
  \item{restr.index}{ index of components of mu, 
            which are subject to the specified constraints as in input index }
  \item{meq}{ as input} 
  \item{iact}{ active restrictions, i.e. restrictions that are satisfied with 
               equality in the solution, as output by \code{solve.QP}} 
}
\author{ Ulrike Groemping, TFH Berlin }
\seealso{ See also \code{\link{ic.test}}, \code{\link{ic.weights}}, 
         \code{\link{orlm}}, \code{solve.QP} }
\examples{
## different correlation structures
corr.plus <- matrix(c(1,0.9,0.9,1),2,2)
corr.null <- matrix(c(1,0,0,1),2,2)
corr.minus <- matrix(c(1,-0.9,-0.9,1),2,2)
## unrestricted vectors
x1 <- c(1, -1)
x2 <- c(-1, -1)
x3 <- c(10, -1)
## estimation under restriction non-negative orthant
## or first element equal to 0, second non-negative
ice <- ic.est(x1, corr.plus, ui=diag(c(1,1)), ci=c(0,0))
ice
summary(ice)
ice2 <-ic.est(x1, corr.plus, ui=diag(c(1,1)), ci=c(0,0), meq=1)
summary(ice2)
ic.est(x2, corr.plus, ui=diag(c(1,1)), ci=c(0,0))
ic.est(x2, corr.plus, ui=diag(c(1,1)), ci=c(0,0), meq=1)
ic.est(x3, corr.plus, ui=diag(c(1,1)), ci=c(0,0))
ic.est(x3, corr.plus, ui=diag(c(1,1)), ci=c(0,0), meq=1)
ic.est(x1, corr.null, ui=diag(c(1,1)), ci=c(0,0))
ic.est(x1, corr.null, ui=diag(c(1,1)), ci=c(0,0), meq=1)
ic.est(x2, corr.null, ui=diag(c(1,1)), ci=c(0,0))
ic.est(x2, corr.null, ui=diag(c(1,1)), ci=c(0,0), meq=1)
ic.est(x3, corr.null, ui=diag(c(1,1)), ci=c(0,0))
ic.est(x3, corr.null, ui=diag(c(1,1)), ci=c(0,0), meq=1)
ic.est(x1, corr.minus, ui=diag(c(1,1)), ci=c(0,0))
ic.est(x1, corr.minus, ui=diag(c(1,1)), ci=c(0,0), meq=1)
ic.est(x2, corr.minus, ui=diag(c(1,1)), ci=c(0,0))
ic.est(x2, corr.minus, ui=diag(c(1,1)), ci=c(0,0), meq=1)
ic.est(x3, corr.minus, ui=diag(c(1,1)), ci=c(0,0))
ic.est(x3, corr.minus, ui=diag(c(1,1)), ci=c(0,0), meq=1)
## estimation under one element restricted to being non-negative
ic.est(x3, corr.plus, ui=1, ci=0, index=1)
ic.est(x3, corr.plus, ui=1, ci=0, index=2)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ multivariate }
\keyword{ optimize }
