\name{bodyfat}
\alias{bodyfat}
\title{ Body fat data from Kutner et al. 2004 }
\docType{data}
\description{
Data set with three explanatory variables and response variable body fat for 
20 healthy females aged 35-44
}
\usage{
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
The data set contains three explanatory variables and the response variable body fat for 
20 healthy females aged 35-44. As the variable body fat is very expensive to obtain, 
predicting it with the cheaper dimensional measurements is desirable. There is 
substantial multicollinearity among the explanatory variables.
}
\source{
  Kutner,M., Nachtsheim,C., Neter J., Li, W. (2005, 5th Ed.).
  \emph{Applied Linear Statistical Models}. McGraw-Hill, New York.
  
  Kutner,M., Nachtsheim,C., Neter J. (2004, 4th Ed.).
  \emph{Applied Linear Regression Models}. McGraw-Hill, New York.
  
  The data are published on the accompanying CD-Roms of those books 
  (Table 1 in Chapter 7) and are also available online 
  on the books homepages or from the UCLA website linked below. 
  (Note that earlier editions of the bood had Neter as first author 
  and included Wasserman as author, but the earlier editions do not have these data.)
}
\references{
UCLA: Statistical Consulting Group (without year). Applied Linear Statistical Models by Neter, Kutner, et. al. Chapter 7: Multiple Regression II | SAS Textbook Examples. 
\url{https://stats.oarc.ucla.edu/sas/examples/alsm/applied-linear-statistical-models-by-neter-kutner-et-al-chapter-7-multiple-regression-ii/} (accessed October 04, 2023).
}
\author{ Ulrike Groemping, BHT Berlin }
% R documentation directory.
\keyword{ datasets }
