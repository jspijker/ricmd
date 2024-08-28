context("ri_put")


test_that("valid arguments", {
              expect_error(ri_put(filename=1))
              expect_error(ri_put(filename="test",collection=1))
              expect_error(ri_put(filename="test",object=1))
              expect_error(ri_put(filename="test",param=1))

              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              expect_error(ri_put(filename=fname.x,collection="nonexistingcollection"))
              unlink(fname.x)
})

test_that("simple data object storage", {

              ri_session(env)
              ri_setCollection(testColl)
              session <- getSession()
              
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)

              ri_put(fname.x)

              expect_true(ri_objectExists(basename(fname.x)))
              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }
              destroySession()


})



test_that("specified data object storage", {

              newColl <- paste(testColl,"test1",sep="/")
              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              ri_createCollection(newColl)
              
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)

              ri_put(fname.x,collection=newColl,object="test_ri-put")

              expect_true(ri_objectExists("test_ri-put",collection=newColl))
              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(newColl,"test_ri-put"))
              }

              ri_removeCollection(newColl)
              destroySession()


})


test_that("overwrite data object", {

              ri_session(env)
              ri_setCollection(testColl)
              session <- getSession()
              
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)

              ri_put(fname.x)
              expect_true(ri_objectExists(basename(fname.x)))

              expect_error(ri_put(fname.x))
              ri_put(fname.x,overwrite=TRUE)



              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              destroySession()

})
