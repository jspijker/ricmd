
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

# create Test list

default.lst <- list(avu=list(list(attribute="key1",value="val1",units="unit1"),
                   list(attribute="key2",value="val2",units=NA)),
          key=list(key1=1,key2=2))


cat("Done!\n")

