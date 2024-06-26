if (requireNamespace("haven", quietly = TRUE) && requireNamespace("sjlabelled", quietly = TRUE)) {
  library(sjmisc)


  test_that("set_na", {
    x <- factor(c("a", "b", "c"))
    expect_equal(nlevels(set_na(x, na = "b", as.tag = TRUE)), 2)
    expect_equal(nlevels(set_na(x, na = "b", drop.levels = FALSE, as.tag = TRUE)), 3)
  })

  test_that("set_na", {
    x <- c(1, 2, 3)
    expect_true(is.null(attr(set_na(x, na = 1, as.tag = FALSE), "labels")))
    expect_true(!is.null(attr(set_na(x, na = 1, as.tag = TRUE), "labels")))

    expect_true(all_na(set_na(x, na = 1:3)))
  })

  test_that("set_na", {
    x <- c(1, 2, NA, 3)
    expect_warning(expect_equal(set_na(x, na = c(1, NA), as.tag = FALSE), c(1, 2, NA, 3)))
    expect_warning(expect_equal(set_na(x, na = NA), c(1, 2, NA, 3)))
    expect_warning(expect_equal(set_na(x, na = NULL), c(1, 2, NA, 3)))
  })
}
