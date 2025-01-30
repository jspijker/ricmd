
test_that("correct function", {

              dir <- tempdir()
              ri_setDatadir(dir)
              res <- ri_getDatadir()
              expect_equal(res,dir)

})
