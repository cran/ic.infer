\name{orlm}
\alias{orlm}
\alias{boot.orlm}
\alias{orlm.forboot.fixed}
\alias{orlm.forboot}
\alias{coef.orlm}
\alias{plot.orlm}
\alias{print.orlm}
\alias{summary.orlm}
\alias{ic.infer}
\alias{ic.infer-package}
\title{ Functions for order restricted linear regression estimation and testing }
\description{
Function orlm calculates order-restricted linear models (linear equality and 
inequality constraints). It uses the internal function boot.orlm for bootstrapping, 
which in turn uses the internal functions orlm.forboot... . 
The remaining functions extract coefficients, provide a residual plot, give a 
short printout or a more extensive summary.
}
\usage{
orlm(model, ui, ci, index = 2:length(coef(model)), meq = 0, 
    orig.out = FALSE, boot = FALSE, B = 1000, fixed = FALSE, 
    tol = sqrt(.Machine$double.eps), ...)
boot.orlm(model, B = 1000, fixed = FALSE, ui, ci, index, meq)
orlm.forboot.fixed(data, indices, ...)
orlm.forboot(data, indices, ...)
\method{coef}{orlm}(object, \dots)
\method{plot}{orlm}(x, caption = "Residuals vs Fitted", 
        panel = if (add.smooth) panel.smooth else points, sub.caption = NULL, 
        main = "", \dots, id.n = 3, labels.id = names(x$residuals), cex.id = 0.75, 
        add.smooth = getOption("add.smooth"), label.pos = c(4, 2), 
        cex.caption = 1)
\method{print}{orlm}(x, digits = max(3, getOption("digits") - 3), \dots)
\method{summary}{orlm}(object, display.unrestr = FALSE, 
        digits = max(3, getOption("digits") - 3), 
        scientific = FALSE, overall.tests = TRUE, 
        bootCIs = TRUE, bty = "perc", level = 0.95, \dots)
}
\arguments{
  \item{model}{ a linear model object (class \code{lm}) with data included }
  \item{ui}{ matrix (or vector in case of one single restriction only) 
             defining the left-hand side of the restriction 
               
               \code{ui\%*\%beta >= ci},
               
            where beta is the parameter vector;         
            the first few of these restrictions can be declared equality- instead
            of inequality restrictions (cf. argument \code{meq}); 
            if only part of the elements of beta are subject to restrictions, 
            the columns of \code{ui} can be restricted to these elements, if their 
            index numbers are provided in \code{index}; by default, \code{index} 
            excludes the intercept, i.e. the columns of \code{ui} refer to the 
            non-intercept elements of \code{coef(model)}
            
            Rows of \code{ui} must be linearly independent; 
            in case of linearly dependent rows the function gives an error 
            message with a hint which subset of rows is independent.
            Note that the restrictions must define a (possibly translated) cone,
            i.e. e.g. interval restrictions on a parameter are not permitted. 
            }
  \item{ci}{ vector on the right-hand side of the restriction (cf. \code{ui}) }
  \item{index}{ index numbers of the components of beta, 
            which are subject to the specified constraints 
             as \code{ui\%*\%beta[index] >= ci},
             default is \code{index = 2:length(coef(model))}, 
             i.e. \code{ui} is supposed to have columns for all coefficients 
             except the intercept;
             
             CAUTIONs: 
             
             - \code{index} refers to the position of the coefficient in the model. 
             The first coefficient is usually the intercept (which is therefore 
             per default excluded from restrictions).
             
             - If the intercept is included into restrictions (model with intercept, 
             index containing the element \code{1}, intercept-related column of ui 
             not consisting of zeroes only), R-squared values may become unreasonable, 
             if the restriction on the intercept is active. 
             }
  \item{meq}{ integer number (default 0) giving the number of rows of \code{ui} that 
             are used for equality restrictions instead of inequality 
             restrictions. 
              }
  \item{orig.out}{ should the original model be included in the output list ? 
             (default: \code{FALSE}) }
  \item{boot}{should bootstrapping be conducted ? (default: \code{FALSE})}
  \item{B}{ number of bootstrap samples (default: \code{1000}) }
  \item{fixed}{ should bootstrapping consider the sample as fixed and bootstrap 
              residuals ? (default: \code{FALSE}) }
  \item{data}{ data handed to bootstrap sampling routine }
  \item{indices}{ indices for sampling }
  \item{tol}{numerical tolerance value; 
             estimates closer to 0 than \code{tol} are set to exactly 0}
  \item{\dots}{ Further options  }
  \item{object}{object of class \code{orlm} (created by function \code{orlm})}
  \item{x}{object of class \code{orlm} (created by function \code{orlm})}
  \item{caption}{ like in function \code{\link{plot.lm}} }
  \item{panel}{ like in function \code{\link{plot.lm}} }
  \item{sub.caption}{ like in function \code{\link{plot.lm}} }
  \item{main}{ like in function \code{\link{plot.lm}} }
  \item{id.n}{ like in function \code{\link{plot.lm}} }
  \item{labels.id}{ like in function \code{\link{plot.lm}} }
  \item{cex.id}{ like in function \code{\link{plot.lm}} }
  \item{add.smooth}{ like in function \code{\link{plot.lm}} }
  \item{label.pos}{ like in function \code{\link{plot.lm}} }
  \item{cex.caption}{ like in function \code{\link{plot.lm}} }
  \item{digits}{ number of digits to display }
  \item{display.unrestr}{ if \code{TRUE}, also display unrestricted model; 
       default: \code{FALSE}}
  \item{scientific}{ if \code{FALSE}, suppresses scientific format; 
        default: \code{FALSE} }
  \item{overall.tests}{ if \code{FALSE}, suppresses output of overall model tests;
        default: \code{TRUE}; for models with large sets of restrictions, 
        tests can take up substantial time because of weight calculation }
  \item{bootCIs}{ if \code{FALSE}, suppresses bootstrap confidence intervals, even 
        though the \code{obj} contains a \code{bootout} element; 
        default: \code{TRUE} }
  \item{bty}{ type of bootstrap confidence interval; any of 
        \code{\dQuote{perc}}, \code{\dQuote{bca}}, \code{\dQuote{norm}} or \code{\dQuote{basic}}, 
        cf. function \code{boot.ci} from package \code{boot},
        default: \code{\dQuote{perc}} }
  \item{level}{ confidence level for bootstrap confidence intervals,
        default: \code{0.95}}
}
\details{
Function \code{orlm} performs order restricted linear model analysis. 
Functions \code{coef.orlm}, \code{plot.orlm}, \code{print.orlm}, and 
\code{summary.orlm} provide methods for reporting the results on an object 
of S3 class orlm. The functions directly referring to bootstrapping are internal 
and should not be called by the user but are called from within function \code{orlm} 
if option \code{boot} is set to \code{TRUE}.

The output from summary.orlm provides information about the restrictions, 
a comparison of $R^2$-values for unrestricted and restricted model, 
restricted estimates, and 

- if requested (option \code{boot} set to \code{TRUE} in function \code{orlm} and 
  option \code{bootCIs} set to \code{TRUE} in the summary function)
  with bootstrap confidence intervals, 

- if requested (option \code{overall.tests} set to \code{TRUE}) 
  several restriction-related tests (implemented by calls to \code{ic.test}):
The analogue to the overall F-Test in the ordinary linear model is the test of 
all coefficients but intercept equal to 0 within the restricted parameter 
space. In addition, three tests related to the restriction are reported:

Test 1: H0: Restriction valid with equality  vs. H1: at least one inequality

Test 2: H0: Restriction valid   vs.  H1: restriction violated

Test 3: H0: Restriction violated or valid with equality 
vs. H1: all restrictions valid with inequality

Test 3 is conducted in case of no equality-restrictions only.

}

\value{
  The output of function \code{orlm} belongs to S3 classes \code{orlm} and \code{orest}. 
  It is a list with the following items:
  \item{b.restr }{restricted estimate}
  \item{b.unrestr }{unrestricted estimate}
  \item{R2}{R-squared}
  \item{residuals }{ residuals of restricted model}
  \item{fitted.values }{fitted values of restricted model}
  \item{weights}{observation weights }
  \item{orig.R2}{R-squared of unrestricted model}
  \item{df.error}{error degrees of freedom of unrestricted model}
  \item{s2 }{MSE of unrestricted model}
  \item{Sigma}{variance covariance matrix of beta-hat in unrestricted model}
  \item{origmodel }{unrestricted model itself (\code{NULL}, 
           if \code{orig.out=FALSE})}
  \item{ui}{ as input}
  \item{ci}{ as input}
  \item{restr.index}{ the input vector index }
  \item{meq}{ as input} 
  \item{iact}{ active restrictions, i.e. restrictions that are satisfied with 
               equality in the solution, as output by \code{solve.QP}} 
  \item{bootout }{object of class boot obtained by bootstrapping, 
         will be used by summary.orlm for calculating bootstrap confidence 
         intervals; \code{NULL} if \code{boot=FALSE}}
}
\references{ Shapiro, A. (1988) Towards a unified theory of inequality-constrained 
    testing in multivariate analysis. \emph{International Statistical Review} 
    \bold{56}, 49--62}
\author{ Ulrike Groemping, TFH Berlin }
\seealso{ See also \code{\link{ic.est}}, \code{\link{ic.test}}, 
        \code{\link{or.relimp}}, \code{solve.QP}}
\examples{
limo <- lm(swiss)
## restricted linear model with restrictions that
## - Education and Examination have same coefficient
## - Catholic and Infant.Mortality have non-negative coefficients
orlimo <- orlm(limo, ui=rbind(c(0,1,-1,0,0),c(0,0,0,1,0),c(0,0,0,0,1)), meq=1)
orlimo
plot(orlimo)
summary(orlimo)
## same model using index vector
orlimo <- orlm(limo, ui=rbind(c(1,-1,0,0),c(0,0,1,0),c(0,0,0,1)), index=3:6, meq=1)

## reduce number of bootstrap samples for example run time
orlimo <- orlm(limo, ui=rbind(c(1,-1,0,0),c(0,0,1,0),c(0,0,0,1)), 
    index=3:6, meq=1, boot=TRUE, B=100)
summary(orlimo)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ htest }
\keyword{ models }
\keyword{ regression }
\keyword{ multivariate }
