context("ri_objectExists")


test_that("valid arguments", {

              expect_error(ri_objectExists(1))
              expect_error(ri_objectExists("test",1))
})

test_that("correct functioning",{

              newColl <- paste(testColl,"test1",sep="/")
              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)

              expect_false(ri_objectExists("testobj1"))
              session$data_objects$create(paste0(testColl,"/testobj1"))
              expect_true(ri_objectExists("testobj1"))
              session$data_objects$unlink(paste0(testColl,"/testobj1"))
              destroySession()
})


