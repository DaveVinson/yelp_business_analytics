# ***************************************************************************************
# ***************************************************************************************
# *********** Get business names and # of reviews, businesses over 200 reviews **********
# ******* Written by David W. Vinson and Rick Dale for the purpose of demonstration *****
# ******************** PLEASE DO NOT DISTRIBUTE WITHOUT PERMISSION **********************  
# ***************************************************************************************
# ***************************************************************************************
print("creating index of business names and # of reviews for businesses over 200 reviews")

#connect to file
bsnFile <- file('/Volumes/Seagate/yelp_dataset_challenge_round9/yelp_academic_dataset_business.json','r',FALSE)
#index for counting
n = 1;
#loop through all businesses 
index <-c();
print("businesses with over 200 reviews")
while (length(bsns <- readLines(bsnFile, n=10000)) > 0) {
  #print the exact number looped through
  print(length(bsns)+(n*10000)-10000)
  i = 0
  #get business's with over 200 reviews
  index <- c(index,lapply(bsns, function(line) 
                      if(fromJSON(line)$review_count>200) {
                        ind <-c(fromJSON(line)$business_id,fromJSON(line)$review_count)
                        return(ind)}))
  n = n + 1
  #print number of businesses loop'd
}
#get the index of the business for easy search
x <- which(sapply(index, is.null)==F)
#convert list to data.tables
b_index <- data.table(index=x,transpose(as.data.table(Filter(Negate(is.null),index))))
colnames(b_index) <- c('index','business_id','review_count')
#save business index, business_id and review count
write.csv(b_index,file="data/b_index.csv")

rm(list = ls())