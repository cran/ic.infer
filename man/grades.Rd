\name{grades}
\alias{grades}
\title{Data set grades: Grade point averages by HSR and ACTC}
\docType{data}
\description{
The data set contains first-year grade point averages (GPAs) from 2397 Iowa university
first-years who entered the university of Iowa as freshmen in the fall of 1978. 
The GPAs are separated out by two ordinal variables with 9 categories each, High-School-Ranking
percentiles and ACT Classification.
}
\usage{
grades
}

\format{
A data frame with four columns:
\describe{
\item{HSR}{high-school-ranking percentiles}
\item{ACTC}{ACT classification (ACT is an organization that offers, among other things, 
college entrance exams in the US; up to 1996, ACT stood for \dQuote{American College Testing}.)}
\item{meanGPA}{grade point average for the HSR/ACTC combination}
\item{n}{sample size for the HSR/ACTC combination}
}
}

\source{
  Robertson T, Wright F, Dykstra R (1988). \emph{Order-Restricted Inference}. Wiley, New York.
  Table 1.3.1, p.13.
  
  Thanks go to Wiley for granting a complimentary license for embedding the data into the package.
}
\author{ Ulrike Groemping, BHT Berlin }
% R documentation directory.
\keyword{ datasets }
