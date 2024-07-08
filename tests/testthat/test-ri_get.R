context("ri_get")


test_that("valid arguments", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              ri_setDatadir(testDatadir)
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
              expect_error(ri_get(object=fname.x,collection="nonexistsingcollection"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})



test_that("simple data object get", {


              ri_session(env)
              ri_setCollection(testColl)
              ri_setDatadir(testDatadir)
              session <- getSession()
              
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)

              ri_put(fname.x)
              unlink(fname.x)

              expect_false(file.exists(file.path(testDatadir,basename(fname.x))))

              ri_get(basename(fname.x))

              expect_true(file.exists(file.path(testDatadir,basename(fname.x))))


              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              destroySession()


})

test_that("specified data object get", {


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


              expect_false(file.exists(file.path(testDatadir,objname)))
              ri_get(object=objname,collection=thisTestColl)
              expect_true(file.exists(file.path(testDatadir,objname)))
              unlink(file.path(testDatadir,objname))

              expect_false(file.exists(file.path(testDatadir,"test1")))
              ri_get(object=objname,collection=thisTestColl,filename="test1")
              expect_true(file.exists(file.path(testDatadir,"test1")))
              unlink(file.path(testDatadir,"test1"))

              extraDatadir <- file.path(tempdir(),"testdir")
              dir.create(extraDatadir)

              expect_false(file.exists(file.path(extraDatadir,"testdir","test1")))
              ri_get(object=objname,collection=thisTestColl,filename="test1",datadir=extraDatadir)
              expect_true(file.exists(file.path(extraDatadir,"test1")))
              unlink(file.path(extraDatadir,"test1"))

              if(ri_objectExists(objname,collection=thisTestColl)) {
                  session$data_objects$unlink(paste0(thisTestColl,"/",objname))
              }

              ri_removeCollection(thisTestColl)
              unlink(extraDatadir,recursive=TRUE)
              destroySession()

})

test_that("overwrite existing file", {



              ri_session(env)
              ri_setCollection(testColl)
              ri_setDatadir(testDatadir)
              session <- getSession()
              
              x <- rnorm (10)
              fname.x <- tempfile()
              objname <- basename(fname.x)
              saveRDS(x,fname.x)

              ri_put(fname.x)
              unlink(fname.x)
              ri_get(objname)
              expect_error(ri_get(objname))
              ri_get(objname,overwrite=TRUE)

              if(ri_objectExists(objname)) {
                  session$data_objects$unlink(paste0(testColl,"/",objname))
              }
              unlink(file.path(testDatadir,objname))



})
