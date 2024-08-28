######################################################################
# ricmd tests
######################################################################
# This is the setup script for the ricmd testing framework. Tests
# needs the irods_demo server (see
# https://github.com/irods/irods_demo)

######################################################################
# Test objects
######################################################################

default.lst <- list(avu=list(list(attribute="key1",value="val1",units="unit1"),
                   list(attribute="key2",value="val2",units=NA)),
          key=list(key1=1,key2=2))



######################################################################
# Start
######################################################################



cat("running setup ...")


if (!ri_test_check_docker()) {
    stop("Docker binary not found")
}

irods_ip <- ri_test_get_catalog_provider_ip()
if (!ri_test_auth_file_exists()) ri_test_create_auth_file()
env <- ri_test_create_demo_env(irods_ip)

irods <- import("irods.session")
session <- irods$iRODSSession(irods_env_file=env)

if (!ri_test_valid_session(session)) {
    stop("No valid iRODS session")
} else {
    cat("iRODS session is valid\n")
}

testColl <- file.path("",session$zone,'home',session$username,"tests")
session$collections$create(testColl)
rm(session)

testDatadir <- file.path(tempdir(),'data')
if(!dir.exists(testDatadir)) {
    dir.create(testDatadir)
}

# create Test list

cat("Done!\n")

