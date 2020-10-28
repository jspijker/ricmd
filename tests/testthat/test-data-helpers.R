context("data helpers")


test_that("testDatadir",{

              ri_session()
              expect_false(ricmd:::testDatadir())
              dir <- tempdir()
              ri_setDatadir(dir)
              expect_true(ricmd:::testDatadir())
              res <- get("datadir",env=.ricmdEnv)
              destroySession()
})

test_that("getDatadir",{

              ri_session()
              dir <- tempdir()
              ri_setDatadir(dir)
              res <- get("datadir",env=.ricmdEnv)
              expect_equal(res,dir)
              destroySession()
})
