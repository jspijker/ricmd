context("ri_metaGetColl")


test_that("valid arguments", {

    expect_error(ri_metaGet(collection = 1))
    expect_error(ri_metaGet(collection = "nonexistingobjectname"))
    expect_error(ri_metaGet(collection = testColl,return_list = "a"))
    destroySession()

})

test_that("proper functioning", {

    ri_session(env)
    ri_createCollection(metacoll)
    session <- getSession()

    ri_metaAddColl(collection = metacoll, attribute = "attr1", value = "val1")
    ri_metaAddColl(collection = metacoll, attribute = "attr2", value = "val2", unit = "unit2")

    mdf <- ri_metaGetColl(collection = metacoll)

    expect_true(all(c("attr1", "attr2") %in% mdf$attribute))
    expect_true(all(c("val1", "val2") %in% mdf$value))
    expect_true(all(c("unit2") %in% mdf$unit))
    expect_null(attr(mdf,"object"))
    expect_equal(attr(mdf,"collection"), metacoll)

    ri_removeCollection(metacoll)
    destroySession()

})
