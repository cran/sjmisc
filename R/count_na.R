#' @title Frequency table of tagged NA values
#' @name count_na
#'
#' @description This method counts tagged NA values (see \code{\link[haven]{tagged_na}})
#'              in a vector and prints a frequency table of counted tagged NAs.
#'
#' @inheritParams to_dummy
#'
#' @return A data frame with counted tagged NA values.
#'
#' @examples
#' if (require("haven")) {
#'   x <- labelled(
#'     x = c(1:3, tagged_na("a", "c", "z"),
#'           4:1, tagged_na("a", "a", "c"),
#'           1:3, tagged_na("z", "c", "c"),
#'           1:4, tagged_na("a", "c", "z")),
#'     labels = c("Agreement" = 1, "Disagreement" = 4,
#'                "First" = tagged_na("c"), "Refused" = tagged_na("a"),
#'                "Not home" = tagged_na("z"))
#'   )
#'   count_na(x)
#'
#'   y <- labelled(
#'     x = c(1:3, tagged_na("e", "d", "f"),
#'           4:1, tagged_na("f", "f", "d"),
#'           1:3, tagged_na("f", "d", "d"),
#'           1:4, tagged_na("f", "d", "f")),
#'     labels = c("Agreement" = 1, "Disagreement" = 4, "An E" = tagged_na("e"),
#'               "A D" = tagged_na("d"), "The eff" = tagged_na("f"))
#'   )
#'
#'   # create data frame
#'   dat <- data.frame(x, y)
#'
#'   # possible count()-function calls
#'   count_na(dat)
#'   count_na(dat$x)
#'   count_na(dat, x)
#'   count_na(dat, x, y)
#' }
#' @export
count_na <- function(x, ...) {
  # evaluate arguments, generate data
  .dat <- get_dot_data(x, dplyr::quos(...))

  # return values
  dataframes <- list()

  if (is.data.frame(x)) {
    # iterate variables of data frame
    for (i in colnames(.dat)) {
      # print freq
      dummy <- count_na_helper(.dat[[i]], cn = i)
      cat(sprintf("# %s\n\n", sjlabelled::get_label(.dat[[i]], def.value = i)))
      print(dummy)
      cat("\n\n")
      # save data frame for return value
      dataframes[[length(dataframes) + 1]] <- dummy
    }
    # return list
    invisible(dataframes)
  } else {
    # get counts
    dummy <- count_na_helper(.dat, cn = names(.dat))

    # check if we have variable label and print, if yes
    vl <- sjlabelled::get_label(.dat)
    if (!is.null(vl)) cat(sprintf("# %s\n\n", vl))

    # print count table
    print(dummy)
    cat("\n")

    # return data frame
    invisible(dummy)
  }
}


count_na_helper <- function(x, cn) {
  if (!requireNamespace("haven", quietly = TRUE)) {
    stop("Package `haven` needed for this function to work. Please install it.", call. = FALSE)
  }

  # check if x has any tagged NA values
  if (sum(haven::is_tagged_na(x)) < 1) {
    message("`x` has no tagged NA values.")
    return(NULL)
  }

  # get NA as tagged NA
  nav <- haven::na_tag(sjlabelled::get_na(x, as.tag = FALSE))
  nav.labels <- names(sjlabelled::get_na(x, as.tag = TRUE))

  # get values from x, including different NA tags
  values <- haven::na_tag(x)

  # only keep missing values
  values <- values[values %in% nav]

  # replace NA tag with label
  for (i in seq_len(length(nav))) {
    values[values == nav[i]] <- nav.labels[i]
  }

  # now compute frequency, and return a proper data frame
  frq_helper(values, sort.frq = "none", weight.by = NULL, cn = cn, auto.grp = NULL) %>%
    dplyr::mutate(label = .data$val) %>%
    dplyr::select(-.data$val) %>%
    dplyr::filter(.data$label != "NA")
}

