# ***************************************************************************************
# ***************************************************************************************
# ********************* Get meta data for desired reviews  ******************************
# ******* Written by David W. Vinson and Rick Dale for the purpose of demonstration *****
# ******************** PLEASE DO NOT DISTRIBUTE WITHOUT PERMISSION **********************  
# ***************************************************************************************
# ***************************************************************************************
print("creating meta data for all desired reviews")

#connect to selected reviews
b_reviews <- file('data/b_reviews.json','r',FALSE)
#get business name (list) index from all desired reviews, this will allow for easy access for looping through each business 
n = 1;
#create "meta" for current meta data on reviews
meta <- c()
while (length(revs <- readLines(b_reviews, n=100000)) > 0) {
  print(length(revs)+(n*100000)-100000)
  #get the meta data, save everything but the text
  meta <- lapply(revs, function(line) 
    return(c(fromJSON(line)[c(1:5,7:9)])) #get all meta data from reviews, except text
  )
  #tranpose/convert meta into matrix
  meta <- as.matrix(t(as.data.table(meta)))
  #add colnames in loop (unfortunately)
  colnames(meta) = c("review_id","user_id","business_id","stars","date","useful","funny","cool")
  #Append and Save. 
  write.table(meta, file = "data/r_meta.csv",append=TRUE,
              #when colnames already exist, don't append them
              col.names = !file.exists("data/r_meta.csv"),
              #write function adds rownames if you don't specify
              row.names = F) 
  #where you are in lopop
  n = n + 1;
}
rm(list = ls())