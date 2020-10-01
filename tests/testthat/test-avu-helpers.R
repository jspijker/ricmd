context("avu-helpers")


test_that("avuStore", {

              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(objname,testColl,attribute="attr1",value="val1")
              avuStore(objname,testColl,attribute="attr1",value="val1") # should not give error
              avuStore(objname,testColl,attribute="attr2",value="val2",units="unit1")
              obj <- session$data_objects$get(file.path(testColl,objname))
              key1 <- obj$metadata$get_one("attr1")
              key2 <- obj$metadata$get_one("attr2")
              expect_equal(key1$value,"val1")
              expect_true(is.null(key1$units))
              expect_equal(key2$units,"unit1")

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()


})


test_that("avuExists", {

              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(objname,testColl,attribute="attr1",value="val1")
              expect_true(avuExists(objname,testColl,attribute="attr1",value="val1"))
              avuStore(objname,testColl,attribute="attr2",value="val2",units="unit1")
              expect_true(avuExists(objname,testColl,attribute="attr2",value="val2",units="unit1"))
              avuStore(objname,testColl,attribute="attr3",value="val3",units="unit3")
              expect_false(avuExists(objname,testColl,attribute="attr3",value="val3"))

              expect_false(avuExists(objname,testColl,attribute="attr1",value="val99"))
              
              obj <- session$data_objects$get(file.path(testColl,objname))
              key1 <- obj$metadata$get_one("attr1")
              key2 <- obj$metadata$get_one("attr2")
              expect_equal(key1$value,"val1")
              expect_true(is.null(key1$units))
              expect_equal(key2$units,"unit1")

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()


})

test_that("avuGet",{


              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(objname,testColl,attribute="attr2",value="val2",units="unit1")
              l <- avuGet(object=objname,collection=testColl)
              expect_true(l$avu[[1]]$attribute=="attr2")
              expect_true(l$key$attr2==1)


              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()


})

test_that("avuRemove", {

              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(objname,testColl,attribute="attr1",value="val1")
              avuStore(objname,testColl,attribute="attr1",value="val1",units="unit1")
              expect_true(avuExists(objname,testColl,attribute="attr1",value="val1",units="unit1"))
              avuRemove(objname,testColl,attribute="attr1",value="val1",units="unit1")
              expect_false(avuExists(objname,testColl,attribute="attr1",value="val1",units="unit1"))

              avuStore(objname,testColl,attribute="attr1",value="val1",units="unit1")
              avuRemove(objname,testColl,attribute="attr1",value="val1")
              expect_false(avuExists(objname,testColl,attribute="attr1",value="val1"))
              expect_true(avuExists(objname,testColl,attribute="attr1",value="val1",units="unit1"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})
