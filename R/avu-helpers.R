#

avuStore <- function(object,collection,attribute,value,units=NULL) {

    session <- getSession()
    objpath <- file.path(collection,object)
    obj <- session$data_objects$get(objpath)
    if(!avuExists(object,collection,attribute,value,units)) {
        obj$metadata$add(attribute,value,units)
    }

}


avuExists <- function(object,collection,attribute,value,units=NULL) {

    doesExist <- FALSE
    l <- avuGet(object,collection)
    if(length(l$key[[attribute]])==0) {
        return(doesExist)
    }
    key<-l$avu[l$key[[attribute]]]
    vals <- unlist(as.data.frame(t(sapply(key,"[")))$value)
    valsidx <- which(vals==value)
    if(length(valsidx)>0) {
        uns <- as.data.frame(t(sapply(key,"[")))$units
        if(is.null(units) && length(units)!=length(valsidx))
            doesExist <- TRUE 
        if(any(uns==units)) {
            doesExist <- TRUE
        }
    }
    return(doesExist)
}

avuGet <- function(object,collection) {

    session <- getSession()
    obj <- session$data_objects$get(file.path(collection,object))
    m <- obj$metadata$items()
    avulst <- list(avu=list(),key=list())
    for (i in m) {
        ndx <- length(avulst$avu)+1
        avulst$avu[[ndx]] <- list(attribute=i$name,
                                   value=i$value,
                                   units=i$units)
        avulst$key[[i$name]] <- append(avulst$key[[i$name]],ndx)
    }
    return(avulst)




}

avuRemove <- function(object,collection,attribute,value,units=NULL) {
    if(avuExists(object,collection,attribute,value,units)) {

        session <- getSession()
        objpath <- file.path(collection,object)

        obj <- session$data_objects$get(objpath)
        obj$metadata$remove(attribute,value,
                            units)
    }
}


