context("ri_metaRemove")

test_that("valid arguments", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              objname <- basename(fname.x)
              ri_put(fname.x)

              expect_error(ri_metaRemove(object=1,))
              expect_error(ri_metaRemove(object=objname,collection=1,value="a",attribute="a"))
              expect_error(ri_metaRemove(object=objname,attribute=1))
              expect_error(ri_metaRemove(object=objname,attribute="a",value=1))
              expect_error(ri_metaRemove(object=objname,attribute="a",value="a",units=1))
              expect_error(ri_metaRemove(object="nonexistsingobject",attribute="a",value="a"))

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
              objname <- basename(fname.x)
              ri_put(fname.x)

              ri_metaAdd(objname,attribute="attr1",value="val1")
              ri_metaAdd(objname,attribute="attr1",value="val1",units="unit1")
              ri_metaAdd(objname,attribute="attr2",value="val2")
              expect_true(avuExists(objname,testColl,attribute="attr1",value="val1"))

              ri_metaRemove(objname,attribute="attr1",value="val1")
              expect_false(avuExists(objname,testColl,attribute="attr1",value="val1"))
              expect_true(avuExists(objname,testColl,attribute="attr1",value="val1",units="unit1"))

              ri_metaAdd(objname,attribute="attr1",value="val1")
              ri_metaRemove(objname,attribute="attr1",value="val1",units="unit1")
              expect_true(avuExists(objname,testColl,attribute="attr1",value="val1"))
              expect_false(avuExists(objname,testColl,attribute="attr1",value="val1",units="unit1"))


              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()



})
