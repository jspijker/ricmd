context("ri_rm")

test_that("valid function arguments",{
              
              expect_error(ri_rm(object=1))
              expect_error(ri_rm(object="test",collection=1))


})

test_that("rm in default collection",{

              ri_session(env)
              ri_setCollection(testColl)
              session <- getSession()
              
              x <- rnorm (10)
              fname.x <- tempfile()
              objname <- basename(fname.x)
              saveRDS(x,fname.x)

              ri_put(fname.x)
              unlink(fname.x)

              expect_true(ri_objectExists(objname))
              ri_rm(objname)
              expect_false(ri_objectExists(objname))

              # should not give an error or warning
              ri_rm(objname)

              if(ri_objectExists(objname)) {
                  session$data_objects$unlink(paste0(testColl,"/",objname))
              }
              destroySession()


})

test_that("rm in default collection",{

              ri_session(env)
              session <- getSession()
              thisTestColl <- file.path(testColl,"testget")
              ri_createCollection(thisTestColl)
              ri_setCollection(testColl)
              
              x <- rnorm (10)
              fname.x <- tempfile()
              objname <- basename(fname.x)
              saveRDS(x,fname.x)

              ri_put(fname.x,collection=thisTestColl)
              unlink(fname.x)

              expect_true(ri_objectExists(objname,collection=thisTestColl))
              ri_rm(objname,collection=thisTestColl)
              expect_false(ri_objectExists(objname,collection=thisTestColl))

              if(ri_objectExists(objname,collection=thisTestColl)) {
                  session$data_objects$unlink(paste0(thisTestColl,"/",objname))
              }

              ri_removeCollection(thisTestColl)
              destroySession()


})
