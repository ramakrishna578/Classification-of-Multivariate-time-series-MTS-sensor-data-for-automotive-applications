# readr library is used to read the csv files into console
# please check the path in the read.csv. 
# with below code we are loading the data which contains only input(features) and output(annotations) into a dataframe n
library(readr)
n <- read.csv("C:/datascience/thesis/manipulateddata/data_classification_cluster/svd/with-time/in.out/all.combined/combined.csv", header = T)
# adding row names
row.names(n) <- n$y
# delete the column contatining names in this case it is 7
n <- n[,-7]
# we are subsetting the data only with the annotatio 0 or 1
# this is useful in the case we cannot replace annotations from the original ok.notok files
m <- subset(n, n$Verhalten == "0")
m1 <- subset(n, n$Verhalten == "1")
# combing both the dataframes with the annotations o and 1
k <- rbind(m,m1)
# converting the class of column verhalten from factor to numeric
k$Verhalten <- as.numeric(k$Verhalten)
set.seed(1000)
library(MASS)
## verifying NA values and errors  in data
apply(k,2,function(x) sum(is.na(x)))
## normalising data between o and 1
normalisation <- function(x){(x - min(x, na.rm = T))/(max(x,na.rm = T)-min(x,na.rm = T))}
ANN <- as.data.frame(lapply(k,normalisation))
# creating randomness in the data
set.seed(1000)
# validating the model using 10-fold cross-validation
cv.error <- NULL
l <- 10
## designing knn classifier
# loading required libraries
library(MASS)
library(plyr)
library(dplyr)
library(nnet)
# to show the status in the console while running the program
pbar <- create_progress_bar('text')
pbar$init(l)
for(i in 1:l){
  # dividing the data into two sections for training and testing the mmodel 
  # we consider 80% of the data for training and 20% for testing the model
  index <- sample(1:nrow(ANN),round(0.80*nrow(ANN)))
  training <- ANN[index,]
  test <- ANN[-index,]
  # seperate the column with annotations to use it as the output for Neuralnetwok and the rest of the data as input
  idc <- class.ind(training$Verhalten)
  #designing NN
  NN <- nnet(training[,-6],idc,size = 10,maxit = 200,softmax = T)
 # predicting class of test data
   nn1 <- predict(NN,test[,-6],type = "class")
  # classification accuracy
  # classification accuracy
  print(paste(table(predict(NN,test[,-6],type = "class"),test$Verhalten)))
  per <- sum(test$Verhalten == nn1)
  print(paste((per/nrow(test))*100))
  pbar$step()
}
