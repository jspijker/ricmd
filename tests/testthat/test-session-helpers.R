context("session-helpers")

test_that("testsession", {

              
              expect_false(testSession())
              ri_session(env)
              expect_true(testSession())
              destroySession() 
})

test_that("getSession",{

              expect_error(getSession())
              ri_session(env)
              s <- getSession()
              expect_true(typeof(s)=="environment")
              destroySession() 

})


test_that("destroySession",{
              ri_session(env)
              expect_true(testSession())
              destroySession() # make sure no session exists
              expect_false(testSession())

})
