context("ri_metaAttExists")


test_that("valid arguments", {

              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              objname <- basename(fname.x)
              ri_put(fname.x)

              expect_error(ri_metaAttExists(object=1,attribute="attr1"))
              expect_error(ri_metaAttExists(object=objname,attribute=1))
              expect_error(ri_metaAttExists(object=objname,attribute="attr1",collection=1))
              expect_error(ri_metaAttExists(object="nonexistingobjectname",attribute="attr1"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()



})

test_that("proper functioning", {
              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              objname <- basename(fname.x)
              ri_put(fname.x)

              ri_metaAdd(objname,attribute="attr1",value="val1")
              expect_true(ri_metaAttExists(objname,attribute="attr1"))
              expect_false(ri_metaAttExists(objname,attribute="nonexistingattr"))



              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})
