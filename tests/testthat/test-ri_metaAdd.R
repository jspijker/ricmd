context("ri_metaAdd")


test_that("valid arguments", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              objname <- basename(fname.x)
              ri_put(fname.x)

              expect_error(ri_metaAdd(object=1))
              expect_error(ri_metaAdd(object=objname,attribute="attr1",value="val2",collection=1))

              expect_error(ri_metaAdd(object=objname,attribute="attr1",value=1))
              expect_error(ri_metaAdd(object=objname,attribute=1,value="val2"))
              expect_error(ri_metaAdd(object=objname,attribute="attr1",value="val2",unit=1))

              expect_error(ri_metaAdd(object=objname,attribute="attr1",value="val2",when_exists="x"))

              expect_error(ri_metaAdd(object="nonexistingobjectname",attribute="attr1",value="val2"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})


test_that("correct functioning", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              ri_metaAdd(objname,attribute="attr1",value="val1")
              obj <- session$data_objects$get(file.path(testColl,objname))
              key1 <- obj$metadata$get_one("attr1")
              expect_equal(key1$value,"val1")

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})
# 
# test_that("option when_exists=overwrite,unique attribute", {
# 
#               ri_session()
#               session <- getSession()
#               ri_setCollection(testColl)
#               x <- rnorm (10)
#               fname.x <- tempfile()
#               saveRDS(x,fname.x)
#               ri_put(fname.x)
#               objname <- basename(fname.x)
# 
#               ri_metaAdd(objname,attribute="attr1",value="val1")
#               expect_error(ri_metaAdd(objname,attribute="attr1",value="val2"))
#               ri_metaAdd(objname,attribute="attr1",value="val2",when_exists="overwrite")
#               obj <- session$data_objects$get(file.path(testColl,objname))
#               key1 <- obj$metadata$get_one("attr1")
#               expect_equal(key1$value,"val2")
# 
# 
#               if(ri_objectExists(basename(fname.x))) {
#                   session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
#               }
# 
#               unlink(fname.x)
#               destroySession()
# 
# 
# 
# })
# 
# 
# test_that("option when_exists=append", {
# 
# 
#               ri_session()
#               session <- getSession()
#               ri_setCollection(testColl)
#               x <- rnorm (10)
#               fname.x <- tempfile()
#               saveRDS(x,fname.x)
#               ri_put(fname.x)
#               objname <- basename(fname.x)
# 
#               ri_metaAdd(objname,attribute="attr1",value="val1")
#               ri_metaAdd(objname,attribute="attr1",value="val2",when_exists="append")
# 
#               obj <- session$data_objects$get(file.path(testColl,objname))
#               key1 <- obj$metadata$get_one("attr1")
#               expect_equal(key1$value,"val2")
# 
# 
#               if(ri_objectExists(basename(fname.x))) {
#                   session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
#               }
# 
#               unlink(fname.x)
#               destroySession()
# 
# 
# 
# })
# 


