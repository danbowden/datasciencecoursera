### Coursera - Data Science Specialization
### Class 2 - R Programming
### Assignment 3
### Rank hospitals in all states

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    
    
    ## Read outcome data
    care <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that inputs are valid
    #use stop function with "invalid state" message if not valid state
    #use stop function with "invalid outcome" message if not valid outcome
    
    if(outcome == 'heart attack'){
        outcome_col = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack'
    } else if (outcome == 'heart failure'){
        outcome_col = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure'
    } else if (outcome == 'pneumonia'){
        outcome_col = 'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia'
    } else {
        stop("invalid outcome")
    }
    
    
    # convert rate column to numeric for comparisons
    care[[outcome_col]] <- as.numeric(care[[outcome_col]])
    care <- care[!is.na(care[[outcome_col]]), ] # remove NA's for desired outcome
    
    
    
    
    ## sort by outcome rate
    # ties go to alphabetical name
    hospitals_sorted <- care[order(care$State, care[[outcome_col]], care$Hospital.Name), ]
    
    hospitals_sorted_split <- split(hospitals_sorted, hospitals_sorted$State)
    #hospitals_sorted_split_ranks <- tapply(hospitals_sorted[[outcome_col]], hospitals_sorted$State, rank)
    hospitals_sorted_split_ranks <- tapply(hospitals_sorted[[outcome_col]], hospitals_sorted$State, rank, ties.method = "first")
    
    hospitals_ranks_combined <- mapply(cbind, hospitals_sorted_split, hospitals_sorted_split_ranks, SIMPLIFY = FALSE)
    #outcome_split_rank <- mapply(cbind, outcome_split, tapply(outcome[[mycol]], outcome$State, rank) , SIMPLIFY = FALSE)
    hospitals_ranks_combined <- unsplit(hospitals_ranks_combined, hospitals_sorted$State)
    
    ## rename the rank column
    names(hospitals_ranks_combined)[names(hospitals_ranks_combined) == "dots[[2L]][[1L]]"]  <- "rankinstate"
    
    
    ##################################
    # still need to check num for max amount of hospitals in single state
    #####################################
    if(num != 'best' && num != 'worst' && num > max( sapply(hospitals_sorted_split, nrow) )){
        # remove NA's when deciding rankings
        # if num is greater than number of hospitals in state, then return NA
        return(NA)
    } 
    
    
    if(num == "best"){
        #hospitals_ranks_combined[ hospitals_ranks_combined[["dots[[2L]][[1L]]"]] == 1 , ]
        #hospitals_ranks_combined[ hospitals_ranks_combined$rankinstate == 1 , ]
        subset(hospitals_ranks_combined, rankinstate == 1, select=c(Hospital.Name, State) )
    } else if(num == "worst"){
        ## need to figure out the worst for each state
        #hospitals_ranks_combined[num]nrow(hospitals_alpha)]  #,na.rm = TRUE
        worst_hosp <- do.call( rbind, by(hospitals_ranks_combined, hospitals_ranks_combined$State, function(x) x[which.max(x$rankinstate), ]))
        subset(worst_hosp, , select = c(Hospital.Name, State) )
    } else {
        # return NA for state without that rank
        #hospitals_ranks_combined[ hospitals_ranks_combined[["dots[[2L]][[1L]]"]] == num, ]
        
        # get list of all states
        allStates <- as.data.frame(levels(factor(hospitals_ranks_combined$State)) )
        colnames(allStates) <- "State"
        hosp_subset <- subset(hospitals_ranks_combined, rankinstate == num, select=c(Hospital.Name, State) )
        merge(allStates, hosp_subset, by = "State", all.x = TRUE)
    }
    
    
}