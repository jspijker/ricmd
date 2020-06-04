context("ri_get")


test_that("valid arguments", {

              ri_session()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)

              expect_error(ri_get(object=1))
              expect_error(ri_get(object=fname.x,collection=1))
              expect_error(ri_get(object=fname.x,filename=1))
              expect_error(ri_get(object=fname.x,path=1))
              expect_error(ri_get(object=fname.x,overwrite=1))

              expect_error(ri_get(object="nonexistsingobject"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})



test_that("simple data object get", {

# 
#               ri_session()
#               ri_setCollection(testColl)
#               session <- getSession()
#               
#               x <- rnorm (10)
#               fname.x <- tempfile()
#               saveRDS(x,fname.x)
# 
#               ri_put(fname.x)
#               unlink(fname.x)
# 
#               ri_get
# 
# 
#               if(ri_objectExists(basename(fname.x))) {
#                   session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
#               }
# 
#               destroySession()
# 

})

test_that("specified data object get", {

})

test_that("overwrite existing file", {

})
