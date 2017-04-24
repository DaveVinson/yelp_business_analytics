# ***************************************************************************************
# ***************************************************************************************
# **************** Create social networks from businesses  ******************************
# ******* Written by David W. Vinson and Rick Dale for the purpose of demonstration *****
# ******************** PLEASE DO NOT DISTRIBUTE WITHOUT PERMISSION **********************  
# ***************************************************************************************
# ***************************************************************************************
print("Building networks, and list of no-network reviewers per business")

# unique business list. 
b_names <- as.list(as.character(read.csv("data/b_index.csv",sep=",",h=T)[3][[1]]))

# all users and businesses for all reviews
ub_list <- read.csv("data/r_meta.csv",sep=" ")[2:3]

# user index 
u_index <- as.list(as.character(read.csv("data/u_users.csv")[[1]]))

# Load entire user file (trimmed so you can do this) in memory to avoid readLines loop
userFile <- readLines(file('data/b_users.json','r',FALSE))

for (n in 1:length(b_names)){
  print(n)
  #get all users for the current business
  c_users <- as.list(as.character(ub_list[which(b_names[[n]]==ub_list$business_id),]$user_id))
  #where are these user's in the user list?
  index <- which(sapply(u_index[match(u_index, unlist(c_users))], is.null)==F)
  #where the action happens
  edges <- lapply(index, function(i)
    if (length(as.numeric(na.omit(match(fromJSON(userFile[i])$friends, unlist(c_users)))))>0){
      friends <- as.character(c_users[as.numeric(na.omit(match(fromJSON(userFile[i])$friends, unlist(c_users))))])
      user <- rep(fromJSON(userFile[i])$user_id,each=length(friends))
      #duplicate the current user to match length of friends list. Bind together
      return(cbind(user,friends))
      }
    )
  #get index of all individual without friends in the business 
  no_net <- do.call(rbind,lapply(index[which(sapply(edges, is.null)==T)],function(i) fromJSON(userFile[i])$user_id))
  #this clean and remove dupilcates (also builds the graph)
  edges <- do.call(rbind, edges)
  #only if there is a network do we save it
  if (!is.null(edges)==T){
    net <- graph.data.frame(edges, directed=F)
    net <- simplify(net, remove.loops=FALSE)
    #take only the main graph component, remove unconnected users 
    edges <- get.data.frame(decompose.graph(net)[[1]])
    #save the graphs and nonet user lists
    write.table(edges,row.names = FALSE,col.names = FALSE,
                file=paste0("data/network/",b_names[[n]],".csv"))
    write.table(no_net,row.names = FALSE,col.names = FALSE,
                file=paste0("data/no_network/",b_names[[n]],".csv"))
  }
}

#plot(net,layout=layout.fruchterman.reingold,vertex.size=1,vertex.label=NA)#,vertex.label=labs,vertex.label.cex=.6)#,vertex.label=labs2)#,vertex.label=NA)
rm(list = ls())

# Note: Users who are not part of the main graph component are dropped completely 
# They are not indpendent, but are also not part of the main graph 

