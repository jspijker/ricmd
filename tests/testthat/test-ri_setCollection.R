context("ri_setCollection")

test_that("valid arguments", {

              testColl <- "/tempZone/home/devel"
              expect_error(ri_setCollection(testColl))

              ri_session()

              expect_error(ri_setCollection("/nonexistingzone/nonexistencollection"))
              expect_error(ri_setCollection(1))
              destroySession()
})

test_that("correct functioning", {

              ri_session()
              testColl <- "/tempZone/home/devel"
              ri_setCollection(testColl)
              coll <- get("collection",env=.ricmdEnv)
              expect_equal(testColl,coll)

              destroySession()


})
