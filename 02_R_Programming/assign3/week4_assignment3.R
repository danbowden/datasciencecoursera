# The Hospital Compare web site contains a lot of data and we will only look at a small subset for this
# assignment. The zip file for this assignment contains three files
# • outcome-of-care-measures.csv: Contains information about 30-day mortality and readmission rates
# for heart attacks, heart failure, and pneumonia for over 4,000 hospitals.
# • hospital-data.csv: Contains information about each hospital.
# • Hospital_Revised_Flatfiles.pdf: Descriptions of the variables in each file (i.e the code book).


##### Question 1
### plot the 30 day mortality rates for heart attack
###
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
# head(outcome)
ncol(outcome)
nrow(outcome)

outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])


#### Question 2
## Find the best hospital in a state
#### see file "best.R"