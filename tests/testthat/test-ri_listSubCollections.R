context("ri_listSubCollections")



test_that("valid arguments", {

              expect_error(ri_listSubCollections(1))

})

test_that("correct functioning",{


              newColl <- paste(testColl,"test1",sep="/")
              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              ri_createCollection(newColl)
              res <- ri_listSubCollections()
              expect_equal("test1",res)

              ri_removeCollection(newColl)
              destroySession()

})

test_that("test collection argument",{


              newColl <- paste(testColl,"test1",sep="/")
              newSubColl <- paste(newColl,"testSub1",sep="/")
              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              ri_createCollection(newColl)
              ri_createCollection(newSubColl)

              res <- ri_listSubCollections(collection=newColl)
              expect_equal("testSub1",res)

              ri_removeCollection(newColl)
              destroySession()

})
