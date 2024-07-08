context("ri_metaGet")


test_that("valid arguments", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              objname <- basename(fname.x)
              ri_put(fname.x)

              expect_error(ri_metaGet(object=1))
              expect_error(ri_metaGet(object=objname,collection=1))
              expect_error(ri_metaGet(object="nonexistingobjectname"))

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
              ri_metaAdd(objname,attribute="attr2",value="val2",unit="unit2")

              mdf <- ri_metaGet(objname)

              expect_true(all(c("attr1", "attr2") %in% mdf$attribute))
              expect_true(all(c("val1", "val2") %in% mdf$value))
              expect_true(all(c("unit2") %in% mdf$unit))
              expect_equal(attr(mdf,"object"),objname)
              expect_equal(attr(mdf,"collection"),testColl)


              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})

test_that("get meta from different collection",{


              ri_session(env)
              session <- getSession()
              thisTestColl <- file.path(testColl,"testget")
              ri_createCollection(thisTestColl)
              ri_setCollection(testColl)
              ri_setDatadir(testDatadir)
              
              x <- rnorm (10)
              fname.x <- tempfile()
              objname <- basename(fname.x)
              saveRDS(x,fname.x)

              ri_put(fname.x,collection=thisTestColl)
              unlink(fname.x)
              expect_true(ri_objectExists(objname,collection=thisTestColl))

              ri_metaAdd(objname,collection=thisTestColl,attribute="attr1",value="val1")
              ri_metaAdd(objname,collection=thisTestColl,attribute="attr2",value="val2",unit="unit2")

              mdf <- ri_metaGet(objname,collection=thisTestColl)
              expect_true(all(c("attr1", "attr2") %in% mdf$attribute))
              expect_true(all(c("val1", "val2") %in% mdf$value))
              expect_true(all(c("unit2") %in% mdf$unit))
              expect_equal(attr(mdf,"object"),objname)
              expect_equal(attr(mdf,"collection"),thisTestColl)


              if(ri_objectExists(objname,collection=thisTestColl)) {
                  session$data_objects$unlink(paste0(thisTestColl,"/",objname))
              }

              ri_removeCollection(thisTestColl)
              destroySession()

})




