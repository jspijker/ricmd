context("ri_metaExists")

test_that("valid arguments", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              objname <- basename(fname.x)
              ri_put(fname.x)

              expect_error(ri_metaExists(object=1,))
              expect_error(ri_metaExists(object=objname,collection=1,value="a",attribute="a"))
              expect_error(ri_metaExists(object=objname,attribute=1))
              expect_error(ri_metaExists(object=objname,attribute="a",value=1))
              expect_error(ri_metaExists(object=objname,attribute="a",value="a",units=1))
              expect_error(ri_metaExists(object="nonexistsingobject",attribute="a",value="a"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()



})

test_that("proper functioning", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(objname,testColl,attribute="attr1",value="val1")
              expect_true(ri_metaExists(objname,attribute="attr1",value="val1"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})
