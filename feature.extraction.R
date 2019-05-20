## set directory and path for the file that contains the raw data
# use the below command in console to specify the path
# setwd("C:/datascience/TO-16017194/T-16114466/MeasurementRawData/Data_KDL1-RT23/Measurement/BSR/_CAN1")
# loading the files within the folder
m <- list.files(pattern = "*.ame")
y <- lapply(m, function(x) read.csv(x, " ",header = T))
names(y) <- m
# caluclating the covariance between each variable current(i), force(f), distance(d), voltage(u)
c_i_f <-  unlist(lapply(y,function(x) cov(x[,1],x[,2])))
c_i_d <- unlist(lapply(y,function(x) cov(x[,1],x[,3])))
c_i_u <- unlist(lapply(y,function(x) cov(x[,1],x[,4])))
c_f_d <- unlist(lapply(y,function(x) cov(x[,2],x[,3])))
c_f_u <- unlist(lapply(y,function(x) cov(x[,2],x[,4])))
c_d_u <- unlist(lapply(y,function(x) cov(x[,3],x[,4])))
# caluclating the euclidean distance between each variable current(i), force(f), distance(d), voltage(u)
e_i_f <- unlist(lapply(y,function(x) dist(rbind(x[,1],x[,2]),method = "euclidean")))
e_i_d <- unlist(lapply(y,function(x) dist(rbind(x[,1],x[,3]),method = "euclidean")))
e_i_u <- unlist(lapply(y,function(x) dist(rbind(x[,1],x[,4]),method = "euclidean")))
e_f_d <- unlist(lapply(y,function(x) dist(rbind(x[,2],x[,3]),method = "euclidean")))
e_f_u <- unlist(lapply(y,function(x) dist(rbind(x[,2],x[,4]),method = "euclidean")))
e_d_u <- unlist(lapply(y,function(x) dist(rbind(x[,3],x[,4]),method = "euclidean")))
# combining the the features with covariance and euclidean distance into one single file
df_in <- data.frame(c_i_f,c_i_d,c_i_u,c_f_d,c_f_u,c_d_u,e_i_f,e_i_d,e_i_u,e_f_d,e_f_u,e_d_u)
write.csv(df_in,"C:/datascience/thesis/manipulateddata/data_classification_cluster/not_ok.csv",row.names = T)
