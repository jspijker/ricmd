context("ri_getCollection")

test_that("correct functioning",{

              ri_session(env)
              expect_error(ri_getCollection()) # collection not set
              ri_setCollection(testColl)
              coll2 <- ri_getCollection()
              expect_equal(testColl,coll2)
              destroySession()



})
