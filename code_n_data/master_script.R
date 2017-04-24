# ***************************************************************************************
# ***************************************************************************************
# *********************** ####### MASTER SCRIPT ########## ******************************
# ******* Written by David W. Vinson and Rick Dale for the purpose of demonstration *****
# ******************** PLEASE DO NOT DISTRIBUTE WITHOUT PERMISSION **********************  
# ***************************************************************************************
# ***************************************************************************************

#load necessary libaries
library(rjson)
library(igraph)
library(data.table)

#set root folder
rootFolder = '~/Documents/github/yelp_business_analytics/code_n_data/' # first SONA study 
setwd(rootFolder)

##########################################################################################
# *********************** Build networks (and other meta data) ***************************
##########################################################################################

# NOTE: Each R file stands as independent from the other, but requires saved data so must be run in order. 

# Get names (and number of reviews) for all businesses with over 200 reviews (arbitrary cutoff)
source("b_index.R")
# trim the larger review dataset to contain only those reviews from businesses of interest
source("b_reviews.R")
# get meta data for all selected reviews
source("r_meta.R")
# Get all .json files for users who reviewed selected businesses
source("b_user.R")
# Get meta ddta for all selected users, This also builds the user index list
source("b_user.R")
# Get networks (saved as matrix) and the no-network user list
source("s_nets.R")

##########################################################################################
# *********************** Build networks (and other meta data) ***************************
##########################################################################################

