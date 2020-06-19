context("ri_metaGetAtt")


test_that("valid arguments", {

              ri_session()
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              objname <- basename(fname.x)
              ri_put(fname.x)

              expect_error(ri_metaGetAtt(object=1,attribute="attr1"))
              expect_error(ri_metaGetAtt(object=objname,attribute=1))
              expect_error(ri_metaGetAtt(object=objname,attribute="attr1",collection=1))
              expect_error(ri_metaGetAtt(object="nonexistingobjectname",attribute="attr1"))

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

              lst <- ri_metaGetAtt(objname,"attr1")
              
              lst_expect <- list(value="val1",unit=NULL)
              expect_equal(lst,lst_expect)




              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})
