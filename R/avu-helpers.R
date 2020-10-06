######################################################################
# This are helper functions for manipulation of avu-triples. These
# function either operates directly on the iRODS data object or
# manipulate an 'avu-triple list. This list is the internal
# representation of the avu-triple meta data from an iRODS object.
######################################################################

avuStore <- function(object,collection,attribute,value,units=NULL) {
    # Stores an avu triple for a data object

    session <- getSession()
    objpath <- file.path(collection,object)
    obj <- session$data_objects$get(objpath)
    if(!avuExists(object,collection,attribute,value,units)) {
        obj$metadata$add(attribute,value,units)
    }

}


avuStoreLst <- function(object,collection,l){
    # stores a list of avu-triples to a data object

    l.obj <- avuGet(object,collection)
    for(i in l$avu) {
        if(!avuExistsLst(l.obj,attribute=i$attribute,value=i$value,unit=i$unit)) {
            if(is.na(i$units)) {
                avuStore(object,collection,attribute=i$attribute,
                         value=i$value)
            } else {
                avuStore(object,collection,attribute=i$attribute,
                         value=i$value,units=i$units)
            }
        }
    }
}



avuExists <- function(object,collection,attribute,value,units=NULL) {
    # check if an avu-tripple allready exists.

    l <- avuGet(object,collection)
    doesExist <- avuExistsLst(l,attribute,value,units)
    return(doesExist)
}

avuExistsLst <- function(l,attribute,value,units=NULL) {
    # check if avu-triple allready exists in an avu-list

    if(is.null(units)) units <- NA
    doesExist <- FALSE
    if(length(l$key[[attribute]])==0) {
        return(doesExist)
    }
    key<-l$avu[l$key[[attribute]]]
    vals <- unlist(as.data.frame(t(sapply(key,"[")))$value)
    valsidx <- which(vals==value)
    if(length(valsidx)>0) {
        uns <- as.data.frame(t(sapply(key,"[")))$units
        if(is.na(units) && any(is.na(uns)))
            doesExist <- TRUE 
        if(!is.na(units)&&any(na.omit(unlist(uns))==units)) {
            doesExist <- TRUE
        }
    }
    return(doesExist)
}


avuGet <- function(object,collection) {
    # get all avu-tripples from a data object, store the avu-tripples
    # in a list

    session <- getSession()
    obj <- session$data_objects$get(file.path(collection,object))
    m <- obj$metadata$items()
    avulst <- list(avu=list(),key=list())
    for (i in m) {
        ndx <- length(avulst$avu)+1
        avulst$avu[[ndx]] <- list(attribute=i$name,
                                   value=i$value,
                                   units=ifelse(is.null(i$units),NA,i$units))
        avulst$key[[i$name]] <- append(avulst$key[[i$name]],ndx)
    }
    attr(avulst,"object") <- object
    attr(avulst,"collection") <- collection
    return(avulst)




}

avuRemove <- function(object,collection,attribute,value,units=NULL) {
    # remove an avu tripple from a data object

    if(avuExists(object,collection,attribute,value,units)) {

        session <- getSession()
        objpath <- file.path(collection,object)

        obj <- session$data_objects$get(objpath)
        obj$metadata$remove(attribute,value,
                            units)
    }
}

avuAddLst <- function(l,attribute,value,units=NA){
    # add an avu-triple to a list with avu-tripples

    if(avuExistsLst(l,attribute,value,units)) {
        avulst <- l
    } else {
        avulst <- list(avu=list(list(attribute=attribute,value=value,
                                     units=ifelse(is.null(units),NA,units))),
                       key=list())
        avulst$key[[attribute]] <- 1
        for (i in l$avu) {
            ndx <- length(avulst$avu)+1
            avulst$avu[[ndx]] <- list(attribute=i$attribute,
                                      value=i$value,
                                      units=ifelse(is.null(i$units),NA,i$units))
            avulst$key[[i$attribute]] <- append(avulst$key[[i$attribute]],ndx)
        }
    }

    return(avulst)

}


avu2df <- function(l) {
    # transform a list with avu triples into a more human readable
    # data.frame

    res <-  as.data.frame(t(matrix(unlist(l$avu),nrow=3)),stringsAsFactors=FALSE)
    names(res) <- c("attribute","value","units")
    attr(res,"object") <- attr(l,"object")
    attr(res,"collection") <- attr(l,"collection")
    return(res)

}

