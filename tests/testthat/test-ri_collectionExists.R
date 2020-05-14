context("collectionExists")


test_that("valid arguments", {

              testColl <- "/tempZone/home/devel"
              expect_error(ri_collectionExists(testColl))

              ri_session()
              expect_error(ri_collectionExists(1))
              destroySession()
})


test_that("correct functioning",{
              
              testColl <- "/tempZone/home/devel"
              newColl <- "test1"
              ri_session()
              ri_setCollection(testColl)
              expect_false(ri_collectionExists("/tempZone/nonexistent"))
              expect_true(ri_collectionExists(testColl))
              destroySession()

})
