
cat("running teardown ...")

# still empty

    
irods <- import("irods.session")
env <- path.expand('~/.irods/irods_environment.json')
session <- irods$iRODSSession(irods_env_file=env)
session$collections$remove(testColl)
rm(session)

cat("Done!\n")
