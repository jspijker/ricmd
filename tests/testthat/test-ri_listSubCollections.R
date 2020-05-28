context("ri_listSubCollections")



test_that("valid arguments", {

              expect_error(ri_listSubCollections(1))

})

test_that("correct functioning",{


              newColl <- paste(testColl,"test1",sep="/")
              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              ri_createCollection(newColl)
              res <- ri_listSubCollections()
              expect_equal("test1",res)

              ri_removeCollection(newColl)
              destroySession()

})
