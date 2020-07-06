# 332 CSV for pollution monitor (each different locations)

# each file has three variables
#   Date: YYYY-MM-DD
#   sulfate: level of sulfate PM in air (micrograms per cubic meter)
#   nitrate: level of nitrate PM in air (micrograms per cubic meter)

complete <- function(directory, id = 1:332){
    ## 'directory is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the 
    ## number of complete cases
    

    # find length/amount of CSV's from id vector
    numfiles <- length(id)

    #create return vector of the length
    mycompcases <- data.frame(id = numeric(), nobs = numeric() )
    #print(mycompcases)
    
    for(i in id){
        #each CSV
        myfile = paste(directory,"/", formatC(i,width=3,flag="0"),".csv",sep="")
        #print(myfile) #lazy debug

        # read each CSV into dataframe
        # subset to 
        temp_df <- read.csv( myfile)
        temp_df <- temp_df[complete.cases(temp_df), ]
        #print( nrow(temp_df) ) # lazy debug
        
        df2 <- c(i, nrow(temp_df))
        #names(df2) <- c("id","nobs")
        names(df2) <- names(mycompcases)
        #print(df2)
        
        
        mycompcases <- rbind( mycompcases, as.list(df2))
        
    }

    mycompcases
}

