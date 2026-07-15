context("ri_metaAddColl")


test_that("valid arguments", {
    ri_session(env)
    ri_createCollection(metacoll)

    expect_error(ri_metaAddColl(collection = 1, attribute = "attr1", value = "val2"))

    expect_error(ri_metaAddCol(collection = testColl, attribute = "attr1", value = 1))
    expect_error(ri_metaAddCol(collection = testColl, attribute = 1, value = "val2"))
    expect_error(ri_metaAddCol(collection = testColl, attribute = "attr1", value = "val2", unit = 1))

    expect_error(ri_metaAddCol(object = "nonexistingobjectname", attribute = "attr1", value = "val2"))

    ri_removeCollection(metacoll)
    destroySession()

})
