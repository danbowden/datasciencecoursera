# 332 CSV for pollution monitor (each different locations)

# each file has three variables
#   Date: YYYY-MM-DD
#   sulfate: level of sulfate PM in air (micrograms per cubic meter)
#   nitrate: level of nitrate PM in air (micrograms per cubic meter)

pollutantmean <- function(directory, pollutant, id=1:332){
    ## 'directory is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating 
    ## the name of the pollutant for which  we will calculate the 
    ## mean; either "sulfate" or "nitrate"
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    ## NOTE: Do not round the result!
    
    # 
    # # find length/amount of CSV's from id vector
    # numfiles <- length(id)
    # 
    # #create return vector of the length
    # mymeans <- numeric(numfiles)
    # 
    # for(i in id){
    #     #each CSV
    #     myfile = paste(directory,"/", formatC(i,width=3,flag="0"),".csv",sep="")
    #     #print(myfile) #lazy debug
    #     
    #     # read each CSV into dataframe
    #     temp_df <- read.csv( myfile)
    #     #print(temp_df) # lazy debug
    #     
    #     # find the mean of specified "pollutant" after removing NA
    #     mymeans[i] <- mean( temp_df[[pollutant]], na.rm = TRUE)
    #     #mymean <- mean( temp_df$pollutant, na.rm = TRUE)
    #     #print(mymeans[i]) #lazy debug
    # }
    # 
    # mymeans
    
    
    # create an overall dataframe (blank)
    allPollutants <- numeric()
    
    for(i in id){
        # Open each file
        myfile = paste(directory,"/", formatC(i,width=3,flag="0"),".csv",sep="")
        #print(myfile) #lazy debug
        
        # load into dataframe
        # subset for pollutant
        # append to running dataframe
        allPollutants <- c(allPollutants, read.csv( myfile)[[pollutant]] )
        
        
    }
        # determine mean of entire dataframe
    mean(allPollutants, na.rm = TRUE)
}

