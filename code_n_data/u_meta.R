# ***************************************************************************************
# ***************************************************************************************
# **************************** User meta data  ******************************************
# ******* Written by David W. Vinson and Rick Dale for the purpose of demonstration *****
# ******************** PLEASE DO NOT DISTRIBUTE WITHOUT PERMISSION **********************  
# ***************************************************************************************
# ***************************************************************************************
print("creating user meta data and unique user index list")

userFile <- readLines(file('data/b_users.json','r',FALSE))

#get u_meta (everything but friends list and 'elite years') 
u_meta <- as.matrix(t(as.data.table(lapply(userFile, function(line) fromJSON(line)[c(1:4,6:9,11:23)]))))
#colnames
colnames(u_meta) <- c("user_id","name","review_count","yelping_since","useful","funny","cool",
"fans","average_stars","compliment_hot","compliment_more","compliment_profile",
"compliment_cute","compliment_list","compliment_note","compliment_plain","compliment_cool",
"compliment_funny","compliment_writer","compliment_photos","type")
#save the file
write.table(u_meta, file = "data/u_meta.csv",sep = ",", row.names = FALSE,col.names = TRUE)

#just extract user information 
u_users <- as.matrix(t(as.data.table(lapply(userFile, function(line) fromJSON(line)[1]))))
write.table(u_users, file = "data/u_users.csv",sep = ",", row.names = FALSE,col.names = TRUE)

rm(list = ls())