library(readr)
m <- read.csv("C:/datascience/thesis/manipulateddata/data_classification_cluster/covar&euclidean/in_out/all_combined/all.csv", header = T,",")
m$X <- NULL
k <- m[,1:7]
n <- m[,8:13]
plot(k)
plot(n)