context("avu-helpers")

# Avustore ####################################################################

test_that("avuStore, store object meta data", {

    ri_session(env)
    session <- getSession()


    expect_true(ri_collectionExists(testColl))


    ri_setCollection(testColl)
    x <- rnorm (10)
    fname.x <- tempfile()
    saveRDS(x,fname.x)
    ri_put(fname.x)
    objname <- basename(fname.x)

    avuStore(testColl, objname, attribute="attr1",value="val1")
    avuStore(testColl, objname, attribute="attr1",value="val1") # should not give error
    avuStore(testColl, objname, attribute="attr2",value="val2",units="unit1")
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


test_that("avuStore, store collection meta data", {

    ri_session(env)
    session <- getSession()
    ri_setCollection(testColl)

    metacoll <- file.path(testColl, "testmetacol")

    # if test fails, remove the collection first
    if (ri_collectionExists(metacoll)) {
        session$collections$remove(metacoll)
    }

    expect_false(ri_collectionExists(metacoll))

    ri_createCollection(metacoll)
    expect_true(ri_collectionExists(metacoll))

    colobj <- session$collections$get(metacoll)
    colobjlst <- colobj$metadata$items()
    expect_equal(length(colobjlst), 0)

    avuStore(metacoll, attribute = "attr1", value = "val1")
    avuStore(metacoll, attribute = "attr2", value = "val2", units = "unit1")

    colobj <- session$collections$get(metacoll)
    colobjlst <- colobj$metadata$items()
    expect_equal(length(colobjlst), 2)

    key1 <- colobj$metadata$get_one("attr1")
    key2 <- colobj$metadata$get_one("attr2")
    expect_equal(key1$value, "val1")
    expect_true(is.null(key1$units))
    expect_equal(key2$units, "unit1")

    session$collections$remove(metacoll)

    destroySession()

})

# avustorelst #################################################################

test_that("avuStoreLst, store object meta data",{

   ri_session(env)
   session <- getSession()

   expect_true(ri_collectionExists(testColl))

   ri_setCollection(testColl)

   x <- rnorm (10)
   fname.x <- tempfile()
   saveRDS(x,fname.x)
   ri_put(fname.x)
   objname <- basename(fname.x)

   l <- default.lst
   avuStoreLst(testColl, objname, l)

   expect_true(avuExists(testColl, objname, attribute="key1",value="val1",units="unit1"))
   expect_false(avuExists(testColl, objname, ,attribute="key1",value="val1"))
   expect_true(avuExists(testColl, objname, ,attribute="key2",value="val2"))

   if(ri_objectExists(basename(fname.x))) {
       session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
   }

   unlink(fname.x)
   destroySession()

})

test_that("avuStoreLst, store collection meta data", {

    ri_session(env)
    session <- getSession()

    expect_true(ri_collectionExists(testColl))

    ri_setCollection(testColl)

    metacoll <- file.path(testColl, "testmetacol")

    # if test fails, remove the collection first
    if (ri_collectionExists(metacoll)) {
        session$collections$remove(metacoll)
    }
    ri_createCollection(metacoll)


    expect_error(avuStoreLst(metacoll, default.lst))
    avuStoreLst(metacoll, l  = default.lst)

    expect_true(avuExists(metacoll, attribute = "key1", value = "val1", units="unit1"))
    expect_false(avuExists(metacoll, attribute = "key1", value = "val1"))
    expect_true(avuExists(metacoll, attribute = "key2", value = "val2"))

    session$collections$remove(metacoll)
    destroySession()

})


# avuExists ####################################################################

test_that("avuExists, test metadata object", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(testColl, objname, attribute="attr1",value="val1")
              expect_true(avuExists(testColl, objname, attribute="attr1",value="val1"))
              expect_false(avuExists(testColl, objname, attribute="attr1",value="val1",units="unit99"))

              avuStore(testColl, objname, attribute="attr2",value="val2",units="unit1")
              expect_true(avuExists(testColl, objname, attribute="attr2",value="val2",units="unit1"))
              avuStore(testColl, objname, attribute="attr3",value="val3",units="unit3")
              expect_false(avuExists(testColl, objname, attribute="attr3",value="val3"))
              expect_true(avuExists(testColl, objname, attribute="attr3",value="val3",units="unit3"))

              expect_false(avuExists(testColl, objname, attribute="attr1",value="val99"))
              
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


test_that("avuExists, test metadata collection", {

    ri_session(env)
    session <- getSession()
    ri_setCollection(testColl)

    metacoll <- file.path(testColl, "testmetacol")

    # if test fails, remove the collection first
    if (ri_collectionExists(metacoll)) {
        session$collections$remove(metacoll)
    }

    ri_createCollection(metacoll)

    avuStore(metacoll, attribute = "attr1", value = "val1")
    expect_true(avuExists(metacoll, attribute = "attr1", value = "val1"))
    expect_false(avuExists(metacoll, attribute = "attr1", value = "val1", units = "unit99"))

    avuStore(metacoll, attribute = "attr2", value = "val2", units = "unit1")
    expect_true(avuExists(metacoll, attribute = "attr2", value = "val2", units = "unit1"))
    avuStore(metacoll, attribute = "attr3", value = "val3", units = "unit3")
    expect_false(avuExists(metacoll, attribute = "attr3", value = "val3"))
    expect_true(avuExists(metacoll, attribute = "attr3", value = "val3", units = "unit3"))

    expect_false(avuExists(metacoll, attribute = "attr1", value = "val99"))

    obj <- session$collections$get(metacoll)
    key1 <- obj$metadata$get_one("attr1")
    key2 <- obj$metadata$get_one("attr2")
    expect_equal(key1$value, "val1")
    expect_true(is.null(key1$units))
    expect_equal(key2$units, "unit1")

    session$collections$remove(metacoll)
    destroySession()


})

# avuExistsLst ####################################################################
test_that("avuExistsLst",{
              l <- default.lst
              expect_true(avuExistsLst(l,attribute="key1",value="val1",units="unit1"))
              expect_false(avuExistsLst(l,attribute="key1",value="val1"))
              expect_true(avuExistsLst(l,attribute="key2",value="val2"))
})


# avuget ######################################################################

test_that("avuGet, object meta data",{


              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              l <- avuGet(object=objname,collection=testColl)
              expect_equal(length(l), 2)
              expect_equal(length(l$avu), 0)

              avuStore(testColl,objname, attribute="attr1",value="val1")
              avuStore(testColl,objname, attribute="attr2",value="val2",units="unit1")
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


test_that("avuGet, collection meta data",{

    ri_session(env)
    session <- getSession()
    ri_setCollection(testColl)

    metacoll <- file.path(testColl, "testmetacol")

    # if test fails, remove the collection first
    if (ri_collectionExists(metacoll)) {
        session$collections$remove(metacoll)
    }

    ri_createCollection(metacoll)

    avuStore(metacoll, attribute = "attr1", value = "val1")
    avuStore(metacoll, attribute = "attr2", value = "val2", units = "unit1")
    l <- avuGet(collection = metacoll)
    expect_true(l$avu[[1]]$attribute == "attr1")
    expect_true(is.na(l$avu[[1]]$units))
    expect_true(l$avu[[2]]$attribute == "attr2")
    expect_true(l$key$attr2 == 2)

    session$collections$remove(metacoll)
    destroySession()


})

# avuremove ####################################################################
test_that("avuRemove, object meta data", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              ri_put(fname.x)
              objname <- basename(fname.x)

              avuStore(testColl, objname, attribute="attr1",value="val1")
              avuStore(testColl, objname, attribute="attr1",value="val1",units="unit1")
              expect_true(avuExists(testColl, objname, attribute="attr1",value="val1",units="unit1"))
              avuRemove(testColl,objname, attribute="attr1",value="val1",units="unit1")
              expect_false(avuExists(testColl, objname, attribute="attr1",value="val1",units="unit1"))

              avuStore(testColl, objname, attribute="attr1",value="val1",units="unit1")
              avuRemove(testColl, objname, attribute="attr1",value="val1")
              expect_false(avuExists(testColl, objname, attribute="attr1",value="val1"))
              expect_true(avuExists(testColl, objname, attribute="attr1",value="val1",units="unit1"))

              if(ri_objectExists(basename(fname.x))) {
                  session$data_objects$unlink(paste0(testColl,"/",basename(fname.x)))
              }

              unlink(fname.x)
              destroySession()

})

test_that("avuRemove, collection meta data", {

    ri_session(env)
    session <- getSession()
    ri_setCollection(testColl)

    metacoll <- file.path(testColl, "testmetacol")

    # if test fails, remove the collection first
    if (ri_collectionExists(metacoll)) {
        session$collections$remove(metacoll)
    }

    ri_createCollection(metacoll)

    avuStore(metacoll, attribute = "attr1", value = "val1")
    avuStore(metacoll, attribute = "attr1", value = "val1", units = "unit1")
    expect_true(avuExists(metacoll, attribute = "attr1", value = "val1", units = "unit1"))
    avuRemove(metacoll, attribute = "attr1", value = "val1", units = "unit1")
    expect_false(avuExists(metacoll, attribute = "attr1", value = "val1", units = "unit1"))

    avuStore(metacoll, attribute = "attr1", value = "val1", units = "unit1")
    avuRemove(metacoll, attribute = "attr1", value = "val1")
    expect_false(avuExists(metacoll, attribute = "attr1", value = "val1"))
    expect_true(avuExists(metacoll, attribute = "attr1", value = "val1", units = "unit1"))

    session$collections$remove(metacoll)
    destroySession()

})


# avuAddLst ####################################################################
test_that("avuAddLst", {
              l <- default.lst
              l <- avuAddLst(l,attribute="key3",value="val3")
              l <- avuAddLst(l,attribute="key4",value="val4",units="unit4")

              expect_true(avuExistsLst(l,attribute="key3",value="val3"))
              expect_false(avuExistsLst(l,attribute="key3",value="val3",units="unit3"))
              expect_false(avuExistsLst(l,attribute="key4",value="val4"))
              expect_true(avuExistsLst(l,attribute="key4",value="val4",units="unit4"))
})



# avu2df ######################################################################
test_that("avu2df", {

              ri_session(env)
              session <- getSession()
              ri_setCollection(testColl)
              x <- rnorm (10)
              fname.x <- tempfile()
              saveRDS(x,fname.x)
              objname <- basename(fname.x)
              ri_put(fname.x)

              # no meta available
              lst <- avuGet(testColl, objname)
              lst.df <- avu2df(lst)
              expect_equal(nrow(lst.df), 0)
              expect_equal(attr(lst.df,"object"),objname)
              expect_equal(attr(lst.df,"collection"),testColl)

              # add meta data, and test again
              ri_metaAdd(objname,attribute="attr1",value="val1")
              ri_metaAdd(objname,attribute="attr2",value="val2",unit="unit2")

              lst <- avuGet(testColl, objname)
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

