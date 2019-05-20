## set directory and path for the file that contains the raw data
# use the below command in console to specify the path
# setwd("C:/datascience/thesis/manipulateddata/maniplateddata/194/CAN_2")
# loading the files within the folder  
m <- list.files(pattern = "*.ame")
y <- lapply(m, function(x) read.csv(x, " ",header = T))
names(y) <- m
# removing the column time
y <- lapply(y, function(x) x[,-5])
# caluclating singular value decomposition between all the four variables
n <- lapply(y, function(x) svd(x))
# considering only svd values
s.v.d <- lapply(n,function(x) x$d)
s.v.d <- as.data.frame(s.v.d)
# transposing the dataframe with svd values
s.v.d <- t(s.v.d)
# adding names of the datafiles as row names 
row.names(s.v.d) <- m
# writing the data into csv file
write.csv(s.v.d,"C:/datascience/thesis/manipulateddata/data_classification_cluster/svd/without_time/only_in/not_ok_196.csv")
