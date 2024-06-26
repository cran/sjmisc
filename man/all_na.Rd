% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/all_na.R
\name{all_na}
\alias{all_na}
\title{Check if vector only has NA values}
\usage{
all_na(x)
}
\arguments{
\item{x}{A vector or data frame.}
}
\value{
Logical, \code{TRUE} if \code{x} has only NA values, \code{FALSE} if
        \code{x} has at least one non-missing value.
}
\description{
Check if all values in a vector are \code{NA}.
}
\examples{
x <- c(NA, NA, NA)
y <- c(1, NA, NA)

all_na(x)
all_na(y)
all_na(data.frame(x, y))
all_na(list(x, y))
}
