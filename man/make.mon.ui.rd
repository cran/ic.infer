\name{make.mon.ui}
\alias{make.mon.ui}
\title{ Function for creating the matrix ui for monotonicity (in)equality restrictions }
\description{
Function \code{make.mon.ui} creates the matrix \code{ui} for a factor, depending on its coding. 
}
\usage{
make.mon.ui(x, type = "coeff", contr = NULL)
}
\arguments{
  \item{x}{ an \code{R} factor (in case of \code{type = "coeff"}) or 
      the dimension of the multivariate normal distribution (in case of \code{type = "mean"}) }
  \item{type}{ the situation for which \code{ui} is needed: can be \code{coeff} 
      for coefficients in a linear model or \code{mean} for the expectation vector 
      of a multivariate normal distribution}
  \item{contr}{ relevant in case of \code{type = "coeff"} only, ignored otherwise;\cr
      the contrast with which \code{x} is coded;\cr
      if the \code{contrasts} attribute of \code{x} is a character string, 
      \code{contr = NULL} uses this character string, otherwise \code{contr = NULL} 
      is identical to \code{contr = "contr.treatment"}.  

      Explicit choices for \code{contr} can be any of \code{contr.treatment}, 
      \code{contr.SAS}, \code{contr.diff} and \code{contr.sum}) (must be given in quotes).\cr 
      The other generally-available 
      codings (\code{contr.helmert} and \code{contr.poly}) do not 
      easily permit conclusions about monotonicity.\cr
      If the value for \code{contr} is not compatible with the factors coding, 
      an error is thrown.}
}
\details{
The function determines the matrix \code{ui} as needed for the functions in 
packge \pkg{ic.infer}, when a monotone increase from first to last level 
of the \code{x} is under investigation (\code{type = "coeff"}) 
or when a monotone increase among the components of the expectation vector is 
investigated (\code{type = "mean"}). The respective monotone decrease can be accomodated 
by \code{-make.mon.ui()}.

If the coding of the factor \code{x} is explicitly given, the function throws an error 
if the actual coding does not correspond to the specified value of \code{contr}.

Care is needed when using \code{make.mon.ui} with a linear model: It is the users responsibility 
to make sure that the coding used in the model corresponds to the coding used in 
\code{make.mon.ui}.
}
\value{
  a square matrix with as many rows and columns as there are dummy variables 
  for the factor 
  }
\author{ Ulrike Groemping, BHT Berlin }
\seealso{ See also \code{\link[stats]{contrasts}} for how to apply contrasts, 
        \code{\link[stats]{contrast}} for the available contrasts in package \pkg{stats}, 
        \code{\link{contr.diff}} for the specific monotonicity contrast function 
        from this package. }
\examples{
gifte <- boot::poisons    ## gifte is German for poisons
## default: contr.treatment (with default base 1)
linmod <- lm(1/time~poison+treat, gifte)
summary(orlm(linmod, ui=make.mon.ui(gifte$poison), index=2:3))

## next: contr.diff
contrasts(gifte$poison) <- "contr.diff" 
linmod <- lm(1/time~poison+treat, gifte)
summary(orlm(linmod, ui=make.mon.ui(gifte$poison), index=2:3))

## next: contr.SAS
contrasts(gifte$poison) <- "contr.SAS"
linmod <- lm(1/time~poison+treat, gifte)
summary(orlm(linmod, ui=make.mon.ui(gifte$poison), index=2:3))

## next: contr.sum
contrasts(gifte$poison) <- "contr.sum"
linmod <- lm(1/time~poison+treat, gifte)
summary(orlm(linmod, ui=make.mon.ui(gifte$poison), index=2:3))


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ multivariate }
\keyword{ optimize }
