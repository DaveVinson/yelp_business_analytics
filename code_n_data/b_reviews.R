# ***************************************************************************************
# ***************************************************************************************
# ************ Get all reviews from businesses with mroe than 200 reviews  **************
# ******* Written by David W. Vinson and Rick Dale for the purpose of demonstration *****
# ******************** PLEASE DO NOT DISTRIBUTE WITHOUT PERMISSION **********************  
# ***************************************************************************************
# ***************************************************************************************
print("creating b_reviews.json file for all reviews from all selected businesses")
#get index, save reviews. from that index. 
require(rjson);
#connect to file
revFile <- file('/Volumes/Seagate/yelp_dataset_challenge_round9/yelp_academic_dataset_review.json','r',FALSE)
#load business names of interest
b_names <- as.list(as.character(read.csv("data/b_index.csv",sep=",",h=T)[3][[1]]))


#for counting the number of reviews you've looped through
n = 1;
print("creates files of all reviews for all businesses over 200 reviews")
#loop through all reviews efficiently by only loading 10,000 at a time 
while (length(revs <- readLines(revFile, n=100000)) > 0) {
  #print the exact number looped through
  print(length(revs)+(n*100000)-100000)
  i = 0
  #get the review_id (this only needs to be a logical)
  ind <- lapply(revs, function(line) 
    if (fromJSON(line)$business_id %in% b_names == T){
      return(fromJSON(line)$review_id)}
  )
  #get the index of reviews from b_names list
  index <- which(sapply(ind, is.null)==F)
  #if the list isn't empty (rare) save the reviews (for later analysis)
  if (length(index)!=0){
    write(revs[index], file = "data/b_reviews.json",append=TRUE) #saves fine
  }
  n = n + 1
  #print number of businesses loop'd
}

rm(list = ls())