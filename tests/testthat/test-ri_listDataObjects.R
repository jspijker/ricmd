context("ri_listDataObjects")



test_that("valid arguments", {

              expect_error(ri_listDataObjects(1))

})

test_that("correct functioning",{


              newColl <- paste(testColl,"test1",sep="/")
              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              ri_createCollection(newColl)
              session$data_objects$create(paste0(testColl,"/testobj1"))

              res <- ri_listDataObjects()
              expect_equal("testobj1",res)
              session$data_objects$unlink(paste0(testColl,"/testobj1"))
              ri_removeCollection(newColl)
              destroySession()

})


test_that("collection argument",{


              newColl <- paste(testColl,"test1",sep="/")
              newSubColl <- paste(testColl,"testSub1",sep="/")
              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              ri_createCollection(newColl)
              ri_createCollection(newSubColl)
              session$data_objects$create(paste0(newSubColl,"/testobj1"))

              res <- ri_listDataObjects(collection=newSubColl)
              expect_equal("testobj1",res)

              session$data_objects$unlink(paste0(newSubColl,"/testobj1"))
              ri_removeCollection(newSubColl)
              ri_removeCollection(newColl)
              destroySession()

})
