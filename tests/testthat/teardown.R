
cat("running teardown ...")

# still empty

    
irods <- import("irods.session")
session <- irods$iRODSSession(irods_env_file=env)
session$collections$remove(testColl)
rm(session)

cat("Done!\n")
