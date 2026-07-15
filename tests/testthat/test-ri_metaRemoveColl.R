context("ri_metaRemove")

test_that("valid arguments", {

    ri_session(env)

    expect_error(ri_metaRemoveColl(object = 1, value = "a", attribute = "a"))
    expect_error(ri_metaRemoveColl(object = testColl, attribute = 1))
    expect_error(ri_metaRemoveColl(object = testColl, attribute = "a", value = 1))
    expect_error(ri_metaRemoveColl(object = testColl, attribute = "a", value = "a", units = 1))
    expect_error(ri_metaRemoveColl(object = "nonexistsingobject", attribute = "a", value = "a"))

    destroySession()

})


test_that("proper functioning", {


    ri_session(env)
    ri_createCollection(metacoll)
    session <- getSession()

    ri_metaAddColl(metacoll, attribute = "attr1", value = "val1")
    ri_metaAddColl(metacoll, attribute = "attr1", value = "val1", units = "unit1")
    ri_metaAddColl(metacoll, attribute = "attr2", value = "val2")
    expect_true(avuExists(metacoll, objname = NULL, attribute = "attr1", value = "val1"))

    ri_metaRemoveColl(metacoll, attribute = "attr1", value = "val1")
    expect_false(avuExists(metacoll, objname = NULL, attribute = "attr1", value = "val1"))
    expect_true(avuExists(metacoll, objname = NULL, attribute = "attr1", value = "val1", units = "unit1"))

    ri_metaAddColl(metacoll, attribute = "attr1", value = "val1")
    ri_metaRemoveColl(metacoll, attribute = "attr1", value = "val1", units = "unit1")
    expect_true(avuExists(metacoll, objname = NULL, attribute = "attr1", value = "val1"))
    expect_false(avuExists(metacoll, objname = NULL, attribute = "attr1", value = "val1", units = "unit1"))

    ri_removeCollection(metacoll)
    destroySession()


})
