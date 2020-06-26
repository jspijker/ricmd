
cat("running setup ...")

env <- path.expand('~/.irods/irods_environment.json')
irods <- import("irods.session")
session <- irods$iRODSSession(irods_env_file=env)
testColl <- file.path("",session$zone,'home',session$username,"tests")
session$collections$create(testColl)
rm(session)

testDatadir <- file.path(tempdir(),'data')
if(!dir.exists(testDatadir)) {
    dir.create(testDatadir)
}


cat("Done!\n")

