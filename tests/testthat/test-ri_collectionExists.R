context("collectionExists")


test_that("valid arguments", {

              expect_error(ri_collectionExists(testColl))

              ri_session(env)
              expect_error(ri_collectionExists(1))
              destroySession()
})


test_that("correct functioning", {

              newColl <- "test1"
              ri_session(env)
              ri_setCollection(testColl)
              expect_false(ri_collectionExists("/tempZone/nonexistent"))
              expect_true(ri_collectionExists(testColl))
              destroySession()

})
