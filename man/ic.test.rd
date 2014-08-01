\name{ic.test}
\alias{ic.test}
\alias{print.ict}
\alias{summary.ict}
\title{ Function for testing inequality-related hypotheses for multivariate 
      normal random variables }
\description{
\code{ic.test} tests linear inequality hypotheses for multivariate normal 
means by likelihood ratio tests. \code{print} and \code{summary} functions 
display results in different degrees of detail.
}
\usage{
ic.test(obj, TP = 1, s2 = 1, df.error = Inf, 
             ui0.11 = diag(rep(1, length(obj$b.restr))), 
             ci0.11 = NULL, meq.alt = 0,
             df = NULL, wt = NULL, tol=sqrt(.Machine$double.eps), \dots)
\method{print}{ict}(x, digits = max(3, getOption("digits") - 3), scientific = FALSE, \dots)
\method{summary}{ict}(object, brief = TRUE, digits = max(3, getOption("digits") - 3), 
             scientific = FALSE, tol=sqrt(.Machine$double.eps), \dots)
}
\arguments{
  \item{obj}{ Object of class \code{orest} that contains unrestricted and 
              restricted estimate, covariance structure, and restriction;
              
              for objects of class \code{orlm} (that inherit from class \code{orest}) 
              information on \code{s2} and \code{df.error} is taken from \code{obj} 
              (i.e. specifications of \code{s2} and \code{df.error} in the call 
              to \code{ic.test} are ignored) }
  \item{TP}{ type of test problem, cf. details}
  \item{s2}{ multiplier that modifies the matrix \code{obj$Sigma} into 
          the (estimated) covariance matrix of the unrestricted estimate;
          \code{obj$Sigma} may be a covariance matrix (\code{s2}=1, default), 
          a correlation matrix or an otherwise rescaled 
          covariance matrix (e.g. \code{cov.unscaled} from a linear model) }
  \item{df.error}{ error degrees of freedom connected with estimation of s2
          (e.g. residual df from linear model);
           if \code{df.error} < Inf, the test is based on a mixture of 
           beta-distributions with parameters \code{df}/2 and \code{df.error}/2,
           otherwise the test is based on a mixture of chi-square distributions 
           with degrees of freedom in \code{df}. }
  \item{ui0.11}{ matrix (or vector in case of one restriction only) 
          for defining (additional) equality restrictions for TP 11
          (in addition to restrictions in obj); 
          
          note that there must be as many columns as there are elements of 
          vector b.restr (no extra index vector taken);
          
          if there is overlap between restrictions in ui0.11 and restrictions 
          already present in obj, restrictions already present in obj are 
          projected out for ui0.11: 
          for example, the default choice for \code{ui0.11} means that all elements 
          of the expectation are 0; some of these restrictions may already be 
          present in \code{obj} and are projected out of \code{ui0.11} 
          by \code{ic.test} }
  \item{ci0.11}{ right-hand-side vector for equality restrictions defined by 
          \code{ui0.11}; so far, these should be 0!}
  \item{meq.alt}{ number of equality restrictions (from beginning) that are 
          maintained under the alternative hypothesis (for TP21) }
  \item{df}{ optional vector of degrees of freedom for mixed chibar- or beta-
         distributions; if omitted, degrees of freedom and weights are calculated;
         if given, must be accompanied by corresponding \code{wt} }
  \item{wt}{ optional vector of weights for mixed chibar- or beta-
         distributions; if omitted, weights are calculated using function 
         \code{ic.weights}; if given, must be accompanied by corresponding 
         \code{df} (can be obtained from call to \code{ic.weights} or 
         from previous runs of \code{ic.test} }
  \item{x}{ output object from \code{ict.test} (of class \code{ict})   }
  \item{tol}{numerical tolerance value; 
             estimates closer to 0 than \code{tol} are set to exactly 0}
  \item{\dots}{ Further options, e.g. algorithm for \code{\link{ic.weights}}  }
  \item{digits}{ number of digits to display }
  \item{scientific}{ if FALSE, suppresses scientific format; 
        default: FALSE }
  \item{object}{  output object from \code{ict.test} (of class \code{ict})   }
  \item{brief}{  if TRUE, requests brief output without restrictions (default), 
                 otherwise restrictions are shown with indication, which are active    }
}
\details{ The following test problems are implemented:
  
  \code{TP=1}: H0: restrictions valid with equality  vs.  H1: at least one inequality
  
  \code{TP=2}: H0: all restrictions true  vs.  H1: at least one restriction false
  
  \code{TP=3}: H0: restrictions false  vs.  H1: restrictions true (with inequality)
  
  \code{TP=11}: H0: restriction valid with equality and further linear equalities
         vs.  H1: at least one equality from H0 violated, restriction valid
         
  \code{TP=21}: H0: restrictions valid (including some equality restrictions)
         vs.  H1: at least one restriction from H0 violated, some equality restrictions
                  are maintained
         
  Note that TPs 1 and 11 can reject H0 even if H1 is violated by the data. 
  Rejection of H0 does not provide evidence for H1 (but only against H0) in  
  these TPs because H1 is not the opposite of H0. The tests concentrate their 
  power in H1, but are only guaranteed to observe their level for the stated H0.
  
  Also note that TP 3 does not make sense if \code{obj} involves equality 
  restrictions (\code{obj$meq}>0). 
  
  Under TPs 1, 2, 11, and 21, the distributions of test statistics are mixtures 
  of chi-square distributions (\code{df.error=Inf}) or beta-distributions (\code{df.error} finite) 
  with different degrees of freedom (chi-square) or parameter combinations (beta). 
  Shapiro (1988) gives detailed information on the mixing weights for the 
  different scenarios. Basically, there are two different situations: 
  
  If \code{meq=0}, 
  the weights are probabilities that a random variable with covariance matrix 
  \code{ui\%*\%cov\%*\%t(ui)} is realized in the positive orthant or its 
  lower-dimensional faces, respectively (if \code{ui} has too few 
  columns, blow up by columns of 0s in appropriate positions) (Shapiro, formulae 
  (5.5) or (5.10), respectively). 
  
  If \code{meq > 0} (but not all restrictions are equality restrictions), 
  the weights are probabilities that a random variable with covariance matrix the 
  inverse of the lower right corner of \code{solve(ui\%*\%cov\%*\%t(ui))} is realized
  in the positive orthant or its lower-dimensional faces, respectively 
  (Shapiro, formula (5.9)).
  
  These weights must then be combined with the appropriate degrees of freedom - 
  these can be worked out by realizing that either the null hypothesis or the 
  alternative hypothesis has fixed dimension and the respective mixing degrees 
  of freedom are obtained by taking the difference to the dimension of the 
  respective other hypothesis, which is correct because - given a certain 
  dimension of the inequality-restricted estimate, the inequality-restricted 
  estimate is a projection onto a linear space of that dimension.
  
  The test for TP 3 (cf. e.g. Sasabuchi 1980) is based on the intersection-union 
  principle and simply obtains its p-value as the maximum p-value from testing 
  the individual restrictions.
  }
\value{object of class \code{ict}, which is a list containing elements
  \item{TP }{test problem identifier (cf. argument \code{TP})}
  \item{b.unrestr }{unrestricted estimate}
  \item{b.restr }{restricted estimate}
  \item{ui }{restriction matrix, LHS}
  \item{ci }{restriction vector, RHS}
  \item{restr.index }{elements of mean referred to by \code{ui} and \code{ci}}
  \item{meq }{number of equality restrictions (first \code{meq} rows of \code{ui}),
         \code{meq} must not exceed \code{nrow(ui)-1}}
  \item{iact }{row numbers of active restrictions (all equality restrictions
         plus inequality restrictions that are met with equality 
         by the solution b.restr)}
  \item{ui.extra }{additional restrictions for \code{TP=11}, 
         calculated from input parameter \code{ui0.11} by projecting out
         restrictions present in \code{ui} and - if necessary - omitting 
         linearly dependent rows}
  \item{b.eqrestr }{equality-restrected estimate for \code{TP=1}}
  \item{b.extra.restr }{estimate for null hypothesis of \code{TP=11} }
  \item{T }{test statistic}
  \item{p.value }{p-value}
  \item{s2 }{input parameter}
  \item{cov }{matrix with \code{s2*cov} equal to covariance matrix of unrestricted estimate}
  \item{df.error }{input parameter}
  \item{df.bar }{vector of degrees of freedom for test statistic distribution, 
          cf. also input parameter \code{df}}
  \item{wt.bar }{vector of weights for test statistic distribution, 
          cf. also input parameter \code{wt}}
}
\references{ 
    Sasabuchi, S. (1980) A test of a multivariate normal mean with composite 
       hypotheses determined by linear inequalities. \emph{Biometrika} 
       \bold{67}, 429--429
       
    Shapiro, A. (1988) Towards a unified theory of inequality-constrained 
       testing in multivariate analysis. \emph{International Statistical Review} 
       \bold{56}, 49--62}
\note{Package versions up to 1.1-4 had a bug that caused p-values for TP=11 
    to be too large.}
\author{ Ulrike Groemping, BHT Berlin }
\seealso{ See also \code{\link{ic.est}}, \code{\link{ic.weights}} }
\examples{
corr.plus <- matrix(c(1,0.5,0.5,1),2,2)
corr.null <- matrix(c(1,0,0,1),2,2)
corr.minus <- matrix(c(1,-0.5,-0.5,1),2,2)
## unrestricted vectors
x1 <- c(1, 1)
x2 <- c(-1, 1)
ict1 <- ic.test(ic.est(x1, corr.plus, ui=diag(c(1,1)), ci=c(0,0)))
ict1
summary(ict1)
ic.test(ic.est(x1, corr.plus, ui=diag(c(1,1)), ci=c(0,0)), s2=1, df.error=10)
ic.test(ic.est(x1, corr.minus, ui=diag(c(1,1)), ci=c(0,0)))
ic.test(ic.est(x1, corr.minus, ui=diag(c(1,1)), ci=c(0,0)), s2=1, df.error=10)
ic.test(ic.est(x2, corr.plus, ui=diag(c(1,1)), ci=c(0,0)))
ic.test(ic.est(x2, corr.plus, ui=diag(c(1,1)), ci=c(0,0)), s2=1, df.error=10)
ic.test(ic.est(x2, corr.minus, ui=diag(c(1,1)), ci=c(0,0)))
ic.test(ic.est(x2, corr.minus, ui=diag(c(1,1)), ci=c(0,0)), s2=1, df.error=10)

ict2 <- ic.test(ic.est(x2, corr.plus, ui=diag(c(1,1)), ci=c(0,0)),TP=2)
summary(ict2)
ict3 <- ic.test(ic.est(x1, corr.plus, ui=diag(c(1,1)), ci=c(0,0)),TP=3)
summary(ict3)

ict11 <- ic.test(ic.est(x1, corr.plus, ui=c(1,1), ci=0),TP=11, ui0.11 =c(1,0))
summary(ict11)

## larger example
corr.plus <- diag(1,8)
for (i in 1:7)
   for (j in (i+1):8)
     corr.plus[i,j] <- corr.plus[j,i] <- 0.5
u <- rbind(rep(1,6), c(-1,-1,-1,1,1,1), c(-1,0,1,0,0,0), c(0,0,0,-1,0,1))
ice <- ic.est(c(rep(1,4),rep(4,4)), corr.plus, ui=u, ci=rep(0,4), index=2:7, meq = 1)
ict1 <- ic.test(ice,TP=1)
summary(ict1)
ict2 <- ic.test(ice,TP=2)
summary(ict2)
ict11 <- ic.test(ice,TP=11)
summary(ict11,digits=3)
ice <- ic.est(c(rep(1,4),rep(4,4)), corr.plus, ui=u, ci=rep(0,4), index=2:7)
ict3 <- ic.test(ice, TP=3)
summary(ict3)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ htest }
\keyword{ multivariate }
