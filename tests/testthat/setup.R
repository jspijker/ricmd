
cat("running setup ...")

# testing environment
testColl <- "/tempZone/home/devel/tests"

env <- path.expand('~/.irods/irods_environment.json')
irods <- import("irods.session")
session <- irods$iRODSSession(irods_env_file=env)
session$collections$create(testColl)
rm(session)

testDatadir <- file.path(tempdir(),'data')
dir.create(testDatadir)


cat("Done!\n")

