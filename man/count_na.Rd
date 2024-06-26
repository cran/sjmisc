% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/count_na.R
\name{count_na}
\alias{count_na}
\title{Frequency table of tagged NA values}
\usage{
count_na(x, ...)
}
\arguments{
\item{x}{A vector or data frame.}

\item{...}{Optional, unquoted names of variables that should be selected for
further processing. Required, if \code{x} is a data frame (and no
vector) and only selected variables from \code{x} should be processed.
You may also use functions like \code{:} or tidyselect's
select-helpers.
See 'Examples' or \href{../doc/design_philosophy.html}{package-vignette}.}
}
\value{
A data frame with counted tagged NA values.
}
\description{
This method counts tagged NA values (see \code{\link[haven]{tagged_na}})
             in a vector and prints a frequency table of counted tagged NAs.
}
\examples{
if (require("haven")) {
  x <- labelled(
    x = c(1:3, tagged_na("a", "c", "z"),
          4:1, tagged_na("a", "a", "c"),
          1:3, tagged_na("z", "c", "c"),
          1:4, tagged_na("a", "c", "z")),
    labels = c("Agreement" = 1, "Disagreement" = 4,
               "First" = tagged_na("c"), "Refused" = tagged_na("a"),
               "Not home" = tagged_na("z"))
  )
  count_na(x)

  y <- labelled(
    x = c(1:3, tagged_na("e", "d", "f"),
          4:1, tagged_na("f", "f", "d"),
          1:3, tagged_na("f", "d", "d"),
          1:4, tagged_na("f", "d", "f")),
    labels = c("Agreement" = 1, "Disagreement" = 4, "An E" = tagged_na("e"),
              "A D" = tagged_na("d"), "The eff" = tagged_na("f"))
  )

  # create data frame
  dat <- data.frame(x, y)

  # possible count()-function calls
  count_na(dat)
  count_na(dat$x)
  count_na(dat, x)
  count_na(dat, x, y)
}
}
