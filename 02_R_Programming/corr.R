# 332 CSV for pollution monitor (each different locations)

# each file has three variables
#   Date: YYYY-MM-DD
#   sulfate: level of sulfate PM in air (micrograms per cubic meter)
#   nitrate: level of nitrate PM in air (micrograms per cubic meter)

corr <- function(directory, threshold = 0){
    ## 'directory is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all 
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    
    
    
    #list out the number of complete pairs using "complete" function
    mycomps <- complete(directory)
    #print(mycomps)
    #print(mycomps[mycomps$nobs > threshold,])
    
    myCompsThreshold <- mycomps[ mycomps$nobs > threshold, ]
    #myFiles <- paste(directory,"/", formatC(i,width=3,flag="0"),".csv",sep="")
    
    mycorrs <- numeric()
    
    for(i in myCompsThreshold$id ){
        # read the i'th file
        myfile <- paste(directory,"/", formatC(i,width=3,flag="0"),".csv",sep="")
        #print(i)
        #print(myfile) #lazy debug
        temp_df <- read.csv(myfile)
        
        
        #print(cor(temp_df$sulfate, temp_df$nitrate, use = "pairwise.complete.obs" ))
        
        # find and add the correlations to return vector
        mycorrs <- c(mycorrs, cor(temp_df["sulfate"], temp_df["nitrate"], use = "pairwise.complete.obs") )        
    }
    
    mycorrs
}
