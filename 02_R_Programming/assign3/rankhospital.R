### Coursera - Data Science Specialization
### Class 2 - R Programming
### Assignment 3
### Rank hospitals in a given state

rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    
    ## Read outcome data
    care <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    #use stop function with "invalid state" message if not valid state
    #use stop function with "invalid outcome" message if not valid outcome
    care_state <- care[care$State == state,]
    if(nrow(care_state) == 0){
        stop("invalid state")
    }
    
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
    care_state[[outcome_col]] <- as.numeric(care_state[[outcome_col]])
    care_state <- care_state[!is.na(care_state[[outcome_col]]), ]
    
    if(num != 'best' && num != 'worst' && num > nrow(care_state)){
        # remove NA's when deciding rankings
        # if num is greater than number of hospitals in state, then return NA
        return(NA)
    } 
    
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
    # sort by outcome rate
    # ties go to alphabetical name
    hospitals_alpha <- care_state[order(care_state[[outcome_col]],care_state$Hospital.Name),]
    
    # return the name of first alpha sorted hospital
    
    if(num == "best"){
        hospitals_alpha$Hospital.Name[1]
    } else if(num == "worst"){
        hospitals_alpha$Hospital.Name[nrow(hospitals_alpha)]  #,na.rm = TRUE
    } else {
        hospitals_alpha$Hospital.Name[num]
    }
    
    
}
