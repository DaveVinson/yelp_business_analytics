# ***************************************************************************************
# ***************************************************************************************
# ************Get all unique user's info who reviewed selecte businesses  ***************
# ******* Written by David W. Vinson and Rick Dale for the purpose of demonstration *****
# ******************** PLEASE DO NOT DISTRIBUTE WITHOUT PERMISSION **********************  
# ***************************************************************************************
# ***************************************************************************************
print("creating json file of all users who reviewed selected businesses (half the original dataset)")

#connect to file
userFile <- file('/Volumes/Seagate/yelp_dataset_challenge_round9/data/yelp_academic_dataset_user.json','r',FALSE)
#load all users who reviewed 
unique_users <-unique(as.character(read.csv("data/r_meta.csv",sep=" ")[2][[1]]))
#for counting the number of reviews you've looped through
n = 1;
print("creates json file of all users who reviewed selected businesses (half the original dataset)")
#loop through all reviews efficiently by only loading 10,000 at a time 
while (length(users <- readLines(userFile, n=10000)) > 0) {
  #print the exact number looped through
  print(length(users)+(n*10000)-10000)
  i = 0
  #get the user_id (this only needs to be a logical)
  ind <- lapply(users, function(line) 
    if (fromJSON(line)$user_id %in% unique_users == T){
      #return the user_id, this just need to be a logical
      return(fromJSON(line)$user_id)}
  )
  #create index, such that you select only those records that have users from the selected businesses
  index <- which(sapply(ind, is.null)==F)
  #if the list isn't empty (rare) save the reviews (for later analysis)
  if (length(index)!=0){
    write(users[index], file = "data/b_users.json",append=TRUE) #saves fine
  }
  n = n + 1
  #print number of businesses loop'd
}

rm(list = ls())