context("collection-helpers")


test_that("testCollection",{
              ri_session()
              expect_false(testCollection())

              testColl <- "/tempZone/home/devel"
              ri_setCollection(testColl)
              expect_true(testCollection())
              destroySession()

})
