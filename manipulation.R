## set directory and path for the file that contains the raw data
# use the below command in console to specify the path
# setwd("C:/datascience/TO-16017194/T-16114466/MeasurementRawData/Data_KDL1-RT23/Measurement/BSR/_CAN1")
# loading the files within the folder  
m <- list.files(pattern = "*.ame")
y <- lapply(m, function(x) read.csv(x,header = F))
names(y) <- m
# n1 <- sapply(y, nrow)
#n2 <- sapply(y, nrow)
#n3 <- sapply(y, nrow)
#n4 <- sapply(y, nrow)
#n5 <- sapply(y, nrow)
n6 <- sapply(y, nrow)
k <- c(n1,n2,n3,n4,n5,n6)
k1 <- subset(k,k >= 3351 & k <= 3352)
