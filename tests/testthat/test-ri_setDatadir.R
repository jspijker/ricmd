context("ri_setDatadir")
test_that("valid funtion arguments", {
              expect_error(datafileInit(datadir=1))
  
})

test_that("set environment vars", {

              dir <- tempdir()
              ri_setDatadir(dir)
              
              res <- get("datadir",env=.ricmdEnv)
              expect_equal(res,dir)
  
})
