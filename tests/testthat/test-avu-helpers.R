context("avu-helpers")


test_that("avuStore", {

              ri_session(env)
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

test_that("avuStoreLst",{

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              l <- default.lst
              avuStoreLst(objname,testColl,l)

              expect_true(avuExists(objname,testColl,attribute="key1",value="val1",units="unit1"))
              expect_false(avuExists(objname,testColl,attribute="key1",value="val1"))
              expect_true(avuExists(objname,testColl,attribute="key2",value="val2"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})


test_that("avuExists", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(objname,testColl,attribute="attr1",value="val1")
              expect_true(avuExists(objname,testColl,attribute="attr1",value="val1"))
              expect_false(avuExists(objname,testColl,attribute="attr1",value="val1",units="unit99"))

              avuStore(objname,testColl,attribute="attr2",value="val2",units="unit1")
              expect_true(avuExists(objname,testColl,attribute="attr2",value="val2",units="unit1"))
              avuStore(objname,testColl,attribute="attr3",value="val3",units="unit3")
              expect_false(avuExists(objname,testColl,attribute="attr3",value="val3"))
              expect_true(avuExists(objname,testColl,attribute="attr3",value="val3",units="unit3"))

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


test_that("avuExistsLst",{
              l <- default.lst
              expect_true(avuExistsLst(l,attribute="key1",value="val1",units="unit1"))
              expect_false(avuExistsLst(l,attribute="key1",value="val1"))
              expect_true(avuExistsLst(l,attribute="key2",value="val2"))
})



test_that("avuGet",{


              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(objname,testColl,attribute="attr1",value="val1")
              avuStore(objname,testColl,attribute="attr2",value="val2",units="unit1")
              l <- avuGet(object=objname,collection=testColl)
              expect_true(l$avu[[1]]$attribute=="attr1")
              expect_true(is.na(l$avu[[1]]$units))
              expect_true(l$avu[[2]]$attribute=="attr2")
              expect_true(l$key$attr2==2)


              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()


})

test_that("avuRemove", {

              ri_session(env)
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


test_that("avuAddLst",{
              l <- default.lst
              l <- avuAddLst(l,attribute="key3",value="val3")
              l <- avuAddLst(l,attribute="key4",value="val4",units="unit4")

              expect_true(avuExistsLst(l,attribute="key3",value="val3"))
              expect_false(avuExistsLst(l,attribute="key3",value="val3",units="unit3"))
              expect_false(avuExistsLst(l,attribute="key4",value="val4"))
              expect_true(avuExistsLst(l,attribute="key4",value="val4",units="unit4"))
})



test_that("avu2df", {

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

              lst <- avuGet(objname,testColl)
              lst.df <- avu2df(lst)

              
              expect_true(all(c("attr1", "attr2") %in% lst.df$attribute))
              expect_true(all(c("val1", "val2") %in% lst.df$value))
              expect_true(all(c("unit2") %in% lst.df$unit))
              expect_equal(attr(lst.df,"object"),objname)
              expect_equal(attr(lst.df,"collection"),testColl)

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})

