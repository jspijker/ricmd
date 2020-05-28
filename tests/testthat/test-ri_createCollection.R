context("ri_createCollection")


test_that("valid arguments", {


              expect_error(ri_collectionExists(testColl))

              ri_session()
              ri_setCollection(testColl)
              expect_error(ri_createCollection(testColl)) # collection exists
              expect_error(ri_createCollection(1))

              expect_error(ri_createCollection("/nonexistingZone/nonexistingCollection"))
              destroySession()

})


test_that("correct functioning",{
              newColl <- paste(testColl,"test1",sep="/")
              ri_session()
              ri_setCollection(testColl)
              ri_createCollection(newColl)
              expect_true(ri_collectionExists(newColl))
              ri_removeCollection(newColl)
              destroySession()

})
