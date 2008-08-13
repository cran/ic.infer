\name{or.relimp}
\alias{or.relimp}
\alias{or.relimp.lm}
\alias{or.relimp.default}
\alias{all.R2}
%- Also NEED an '\\alias' for EACH other topic documented here.

\title{ Function to calculate relative importance for order-restricted 
 linear models }

\description{
  The function calculates relative importance by averaging over the variables 
  R-squared contributions from all orderings of variables for linear models with 
  inequality restrictions on the parameters. 
  NOTE: only useful if each restriction refers to exactly one variable,
  or if it is adequate to reduce multi-variable restrictions by omitting 
  the affected variables but leaving the restriction otherwise intact.
}

\usage{
or.relimp(model, ui, ci = NULL, ...)
\method{or.relimp}{lm}(model, ui, ci = NULL, index = 2:length(coef(model)), meq = 0, 
     tol = sqrt(.Machine$double.eps), ...)
     
\method{or.relimp}{default}(model, ui, ci = NULL, index = 2:ncol(model), meq = 0, 
     tol = sqrt(.Machine$double.eps), ...)
     
all.R2(covmat, ui, ci = NULL, index = 2:ncol(covmat), meq = 0, 
     tol = sqrt(.Machine$double.eps), ...)
     ## user does not need to call this function
}

\arguments{
\item{model}{ a linear model object of class \code{lm} with data included; 
            for function \code{or.relimp}, 
            all explanatory variables must be numeric (i.e. no factors), 
            and higher-order terms (e.g. interactions) are not permitted. 
            
            OR
            
            the covariance matrix of the response (first position) and all regressors}
\item{covmat}{ the covariance matrix of the response (first position) and all regressors}
\item{ui}{ cf. explanation in \code{link{orlm}};
           cf. also details below }
\item{ci}{ cf. explanation in \code{link{orlm}} }
\item{index}{ cf. explanation in \code{link{orlm}} }
\item{meq}{ cf. explanation in \code{link{orlm}} }
\item{tol}{ cf. explanation in \code{link{orlm}} }
\item{\dots}{ Further options }
}

\details{
           Function \code{or.relimp} uses function \code{all.R2} for 
           calculating the R-squared values of all subsets that are subsequently 
           handed to function \code{Shapley.value} (from package \code{kappalab}), 
           which takes care of the averaging over ordering. 

           WARNING: In models with subsets of the regressors, the 
           columns of the matrix \code{ui} referring to regressors outside the 
           current subset are simply deleted for the sub model. 
           This is only reasonable if either the individual 
           constraints refer to individual parameters only (e.g. all 
           parameters restricted to be non-negative) or if the constraints 
           are still reasonable in the sub model with some variables deleted, 
           e.g. perhaps (depending on the application) sum 
           of all parameters less or equal to 1.
           
           WARNING: If the number of regressors (\code{p}) is large, the functions 
           quickly becomes unmanageable (a vector of size \code{2^p} is returned 
           or handled in the process.
}

\value{
\code{all.R2} returns a vector (\code{2^p} elements) with all R-squared values 
(\code{p} is the number of regressors, vector is ordered from empty to full model 
in natural order (cf. \code{ic.infer:::nchoosek} for the order within one model 
size).

\code{or.relimp} returns a vector (\code{p} elements) with average R-squared 
contributions from all models with respective subset of restrictions 
\code{ui \%*\% beta >= ci} enforced. 
}

\author{ Ulrike Groemping, TFH Berlin }
\seealso{ See also \code{\link{orlm}} for order-restricted linear models and 
    \code{calc.relimp} from \code{R}-package \code{relaimpo} for a much more 
    comfortable and much faster routine for unrestricted linear models}
\examples{
covswiss <- cov(swiss)
## all R2-values for restricted linear model with restrictions that
## Catholic and Infant.Mortality have non-negative coefficients
R2s <- all.R2(covswiss, ui=rbind(c(0,0,0,1,0),c(0,0,0,0,1)))
R2s

Shapley.value(set.func(R2s))  ## directly using package kappalab

### with convenience wrapper from this package
or.relimp(covswiss, ui=rbind(c(0,0,0,1,0),c(0,0,0,0,1)))

### also works on linear models
limo <- lm(swiss)
#or.relimp(limo, ui=rbind(c(0,0,0,1,0),c(0,0,0,0,1)))

## same model using index vector
or.relimp(limo, ui=rbind(c(1,0),c(0,1)), index=5:6)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models }
\keyword{ regression }
\keyword{ multivariate }
