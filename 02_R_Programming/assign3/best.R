### Coursera - Data Science Specialization
### Class 2 - R Programming
### Assignment 3
### Find best hospital in a given state


best <- function(state, outcome) {
    # 'state' is two character abbreviation for state
    # 'outcome' is one of "heart attack", "heart failure", or "pneumonia"
    # Hospitals with no data on outcome excluded
    # ties will go to first alphabetical hospital
    
    
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
    
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    
    # convert rate column to numeric for comparisons
    care_state[[outcome_col]] <- as.numeric(care_state[[outcome_col]])
    
    # get best hospitals
    bestrate = min(care_state[[outcome_col]], na.rm = TRUE)
    best_hospitals <- care_state[care_state[[outcome_col]] == bestrate,]
    
    # sort alpha by hospital name
    best_hospitals_alpha <- best_hospitals[order(best_hospitals$Hospital.Name),]
    
    # return the name of first alpha sorted hospital
    best_hospitals_alpha$Hospital.Name[1]
    
}