context("ri_removeCollection")


test_that("valid arguments", {


              testColl <- "/tempZone/home/devel"
              expect_error(ri_removeCollection(1))
})


test_that("correct functioning",{


              testColl <- "/tempZone/home/devel"
              newColl <- paste(testColl,"test1",sep="/")
              ri_session()
              ri_setCollection(testColl)
              expect_false(ri_collectionExists(newColl))
              ri_createCollection(newColl)
              expect_true(ri_collectionExists(newColl))
              ri_removeCollection(newColl)
              expect_false(ri_collectionExists(newColl))

})
