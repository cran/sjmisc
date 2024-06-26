% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/frq.R
\name{frq}
\alias{frq}
\title{Frequency table of labelled variables}
\usage{
frq(
  x,
  ...,
  sort.frq = c("none", "asc", "desc"),
  weights = NULL,
  auto.grp = NULL,
  show.strings = TRUE,
  show.na = TRUE,
  grp.strings = NULL,
  min.frq = 0,
  out = c("txt", "viewer", "browser"),
  title = NULL,
  encoding = "UTF-8",
  file = NULL
)
}
\arguments{
\item{x}{A vector or a data frame. May also be a grouped data frame
(see 'Note' and 'Examples').}

\item{...}{Optional, unquoted names of variables that should be selected for
further processing. Required, if \code{x} is a data frame (and no
vector) and only selected variables from \code{x} should be processed.
You may also use functions like \code{:} or tidyselect's
select-helpers.
See 'Examples' or \href{../doc/design_philosophy.html}{package-vignette}.}

\item{sort.frq}{Determines whether categories should be sorted
according to their frequencies or not. Default is \code{"none"}, so
categories are not sorted by frequency. Use \code{"asc"} or
\code{"desc"} for sorting categories ascending or descending order.}

\item{weights}{Bare name, or name as string, of a variable in \code{x}
that indicates the vector of weights, which will be applied to weight all
observations. Default is \code{NULL}, so no weights are used.}

\item{auto.grp}{Numeric value, indicating the minimum amount of unique
values in a variable, at which automatic grouping into smaller  units
is done (see \code{\link{group_var}}). Default value for \code{auto.group}
is \code{NULL}, i.e. auto-grouping is off.}

\item{show.strings}{Logical, if \code{TRUE}, frequency tables for character
vectors will not be printed. This is useful when printing frequency tables
of all variables from a data frame, and due to computational reasons
character vectors should not be printed.}

\item{show.na}{Logical, or \code{"auto"}. If \code{TRUE}, the output always
contains information on missing values, even if variables have no missing
values. If \code{FALSE}, information on missing values are removed from
the output. If \code{show.na = "auto"}, information on missing values
is only shown when variables actually have missing values, else it's not
shown.}

\item{grp.strings}{Numeric, if not \code{NULL}, groups string values in
character vectors, based on their similarity. See \code{\link{group_str}}
and \code{\link{str_find}} for details on grouping, and their
\code{precision}-argument to get more details on the distance of strings
to be treated as equal.}

\item{min.frq}{Numeric, indicating the minimum frequency for which a
value will be shown in the output (except for the missing values, prevailing
\code{show.na}). Default value for \code{min.frq} is \code{0}, so all value
frequencies are shown. All values or categories that have less than
\code{min.frq} occurences in the data will be summarized in a \code{"n < 100"}
category.}

\item{out}{Character vector, indicating whether the results should be printed
to console (\code{out = "txt"}) or as HTML-table in the viewer-pane
(\code{out = "viewer"}) or browser (\code{out = "browser"}).}

\item{title}{String, will be used as alternative title to the variable
label. If \code{x} is a grouped data frame, \code{title} must be a
vector of same length as groups.}

\item{encoding}{Character vector, indicating the charset encoding used
for variable and value labels. Default is \code{"UTF-8"}. Only used
when \code{out} is not \code{"txt"}.}

\item{file}{Destination file, if the output should be saved as file.
Only used when \code{out} is not \code{"txt"}.}
}
\value{
A list of data frames with values, value labels, frequencies, raw, valid and
          cumulative percentages of \code{x}.
}
\description{
This function returns a frequency table of labelled vectors, as data frame.
}
\details{
The \dots-argument not only accepts variable names or expressions
  from select-helpers. You can also use logical
  conditions, math operations, or combining variables to produce "crosstables".
  See 'Examples' for more details.
}
\note{
\code{x} may also be a grouped data frame (see \code{\link[dplyr]{group_by}})
      with up to two grouping variables. Frequency tables are created for each
      subgroup then.
      \cr \cr
      The \code{print()}-method adds a table header with information on the
      variable label, variable type, total and valid N, and mean and
      standard deviations. Mean and SD are \emph{always} printed, even for
      categorical variables (factors) or character vectors. In this case,
      values are coerced into numeric vector to calculate the summary
      statistics.
      \cr \cr
      To print tables in markdown or HTML format, use \code{print_md()} or
      \code{print_html()}.
}
\examples{
# simple vector
data(efc)
frq(efc$e42dep)

# with grouped data frames, in a pipe
library(dplyr)
efc \%>\%
  group_by(e16sex, c172code) \%>\%
  frq(e42dep)

# show only categories with a minimal amount of frequencies
frq(mtcars$gear)

frq(mtcars$gear, min.frq = 10)

frq(mtcars$gear, min.frq = 15)

# with select-helpers: all variables from the COPE-Index
# (which all have a "cop" in their name)
frq(efc, contains("cop"))

# all variables from column "c161sex" to column "c175empl"
frq(efc, c161sex:c175empl)

# for non-labelled data, variable name is printed,
# and "label" column is removed from output
data(iris)
frq(iris, Species)

# also works on grouped data frames
efc \%>\%
  group_by(c172code) \%>\%
  frq(is.na(nur_pst))

# group variables with large range and with weights
efc$weights <- abs(rnorm(n = nrow(efc), mean = 1, sd = .5))
frq(efc, c160age, auto.grp = 5, weights = weights)

# different weight options
frq(efc, c172code, weights = weights)
frq(efc, c172code, weights = "weights")
frq(efc, c172code, weights = efc$weights)
frq(efc$c172code, weights = efc$weights)

# group string values
dummy <- efc[1:50, 3, drop = FALSE]
dummy$words <- sample(
  c("Hello", "Helo", "Hole", "Apple", "Ape",
    "New", "Old", "System", "Systemic"),
  size = nrow(dummy),
  replace = TRUE
)

frq(dummy)
frq(dummy, grp.strings = 2)

#### other expressions than variables

# logical conditions
frq(mtcars, cyl ==6)

frq(efc, is.na(nur_pst), contains("cop"))

iris \%>\%
  frq(starts_with("Petal"), Sepal.Length > 5)

# computation of variables "on the fly"
frq(mtcars, (gear + carb) / cyl)

# crosstables
set.seed(123)
d <- data.frame(
  var_x = sample(letters[1:3], size = 30, replace = TRUE),
  var_y = sample(1:2, size = 30, replace = TRUE),
  var_z = sample(LETTERS[8:10], size = 30, replace = TRUE)
)
table(d$var_x, d$var_z)
frq(d, paste0(var_x, var_z))
frq(d, paste0(var_x, var_y, var_z))
}
\seealso{
\code{\link{flat_table}} for labelled (proportional) tables.
}
