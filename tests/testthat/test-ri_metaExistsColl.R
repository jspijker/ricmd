context("ri_metaExistsColl")

test_that("valid arguments", {

    ri_session(env)
    ri_createCollection(metacoll)

    expect_error(ri_metaExistsColl(collection = 1, value = "a", attribute = "a"))
    expect_error(ri_metaExistsColl(collection = metacoll, attribute = 1))
    expect_error(ri_metaExistsColl(collection = metacoll, attribute = "a", value = 1))
    expect_error(ri_metaExistsColl(collection = metacoll, attribute = "a", value = "a", units = 1))
    expect_error(ri_metaExistsColl(collection = "nonexistsingobject", attribute = "a", value = "a"))

    ri_removeCollection(metacoll)
    destroySession()



})

test_that("proper functioning", {

    ri_session(env)
    session <- getSession()
    ri_setCollection(testColl)
    ri_createCollection(metacoll)

    avuStore(collection = metacoll, object = NULL, attribute = "attr1", value = "val1")
    expect_true(ri_metaExistsColl(collection = metacoll, attribute = "attr1", value = "val1"))

    ri_removeCollection(metacoll)
    destroySession()

})
