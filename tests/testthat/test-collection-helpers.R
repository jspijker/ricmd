context("collection-helpers")


test_that("testCollection",{
              ri_session()
              expect_false(testCollection())

              ri_setCollection(testColl)
              expect_true(testCollection())
              destroySession()

})
