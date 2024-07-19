context("collection-helpers")


test_that("testCollection",{
              ri_session(env)
              expect_false(testCollection())

              ri_setCollection(testColl)
              expect_true(testCollection())
              destroySession()

})

test_that("getCollectionObjects",{


              newColl <- paste(testColl,"test1",sep="/")
              newSubColl <- paste(newColl,"testSub1",sep="/")
              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              ri_createCollection(newColl)
              ri_createCollection(newSubColl)
              cols1 <- getCollectionObjects()
              cols2 <- session$collections$get(testColl)
              expect_equal(cols1,cols2)

              cols1 <- getCollectionObjects(collection=newColl)
              cols2 <- session$collections$get(newColl)
              expect_equal(cols1,cols2)

              ri_removeCollection(newColl)
              destroySession()




})
