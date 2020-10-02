context("ri_metaGet")


test_that("valid arguments", {

              ri_session()
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

              ri_session()
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
              #expect_equal(lst$avu[[1]]$attribute,"attr1")
              expect_equal(nrow(mdf),2)
              expect_equal(ncol(mdf),3)
              expect_equal(attr(mdf,"object"),objname)
              expect_equal(attr(mdf,"collection"),testColl)


              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})
