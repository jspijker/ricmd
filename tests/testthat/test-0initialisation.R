context("initialisation")

test_that("onAttach and ricmdEnv", {

              expect_true(exists("onAttach_success",where=.ricmdEnv))
              expect_true(get("onAttach_success",envir=.ricmdEnv))

})

