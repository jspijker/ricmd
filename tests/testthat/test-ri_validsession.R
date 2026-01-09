test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})



test_that("valid session",{

              ri_session(env)
              expect_true(ri_validsession())
              destroySession()

})

test_that("Invalid session",{

              # create a 'wrong' env file
              env <- ri_test_create_demo_env(irods_ip,
                                             password = "wrong")

              ri_session(env)
              expect_error(ri_validsession())

              # reset env for next test.
              env <- ri_test_create_demo_env(irods_ip)

              destroySession()

})
