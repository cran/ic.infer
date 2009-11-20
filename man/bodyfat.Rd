\name{bodyfat}
\alias{bodyfat}
\title{ Body fat data from Neter et al. 1996 }
\docType{data}
\description{
Data set with three explanatory variables and response variable body fat for 
20 females. It comes from Neter et al., Chapter 7, Table 1 and is downloaded 
from UCLA ATS whenever bodyfat() is executed.
}
\usage{
bodyfat()
bodyfat
}

\format{
A data frame with four columns:
\describe{
\item{Triceps}{triceps skinfold thickness}
\item{Thigh}{thigh circumference}
\item{Midarm}{midarm circumference}
\item{BodyFat}{body fat}
}
}
\details{
The data are usable with an existing internet connection only. The function call 
\code{bodyfat()} downloads the data from the UCLA ATS website and creates the 
data frame \code{bodyfat} that is subsequently present in the global environment.
}
\source{
  Neter,J., Kutner,M., Nachtsheim,C., Wasserman W. (1996, 4th Ed.).
  \emph{Applied Linear Statistical Models}. McGraw-Hill, New York.
  
  The data come from Table 1 in Chapter 7 of that book. 
  
  Note: The data are usable with an internet connection only, 
  because McGraw-Hill was unable to grant a license for embedding the data into the package.
}
\references{
UCLA: Academic Technology Services, Statistical Consulting Group (2009). Textbook examples. 
\url{http://www.ats.ucla.edu/stat/examples/default.htm} (accessed September 18, 2009).
}
\author{ Ulrike Groemping, BHT Berlin }
% R documentation directory.
\keyword{ datasets }
