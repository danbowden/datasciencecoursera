add2 <- function(x,y){
    x+y
}

above10 < function(x){
    use <- x>10
    x[use]
}

above <- function(x,n=10){ # setting equal in function def creates defaults
    use <- x > n
    x[use]
}

columnmean <- function(y, removeNA=TRUE){
    nc <- ncol(y)
    means <- numeric(nc)
    
    for(i in nc){
        means[i] <- mean(y[,i], na.rm = removeNA)
    }
    means
    #return( means)
}