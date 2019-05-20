# readr library is used to read the csv files into console
# please check the path in the read.csv. 
# with below code we are loading the data which contains only input(features) and output(annotations) into a dataframe n
library(readr)
n <- read.csv("C:/datascience/thesis/manipulateddata/data_classification_cluster/covar&euclidean/in_out/all_combined/all.csv", header = T)
# adding row names
row.names(n) <- n$X
# removing the column x as we added it as the row names
n <- n[,-1]
# we are subsetting the data only with the annotatio 0 or 1
# this is useful in the case we cannot replace annotations from the original ok.notok files
m <- subset(n, n$verhalten == "0")
m1 <- subset(n, n$verhalten == "1")
# combing both the dataframes with the annotations o and 1
k <- rbind(m,m1)
# converting the class of column verhalten from factor to numeric
k$verhalten <- as.numeric(k$verhalten)
# use the below code for filtering select the required columns
# k <- k[,c(1,2:7)]
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
## designing neural network
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
  idc <- class.ind(training$verhalten)
  # training the neural network
  NN <- nnet(training[,-1],idc,size = 15,maxit = 200,softmax = T)
  # predicting the class of the test data
  nn1 <- predict(NN,test[,-1],type = "class")
  # classification accuracy
  # caluclating the accuracy of the predicted data with respect to test data
  print(paste(table(predict(NN,test[,-1],type = "class"),test$verhalten)))
  per <- sum(test$verhalten == nn1)
  print(paste((per/nrow(test))*100))
  tp <- sum(test$verhalten == 1 & nn1 == 1)
  tn <- sum(test$verhalten == 0 & nn1 == 0)
  fn <- sum(test$verhalten == 0 & nn1 == 1)
  fp <- sum(test$verhalten == 1 & nn1 == 0)
  # evaluation of model
  # precision
  precision <- tp/(tp + fp)
  print(precision)
  # recall
  recall <- tp/(tp + fn)
  print(recall)
  # F masure
  F_measure <- 2*((precision*recall)/(precision + recall))
  print(F_measure)
  # senstivity
  senstivity <- tp/(tp + fn)
  print(senstivity)
  #specificity 
  specificity <- tn/(tn + fp)
  print(specificity)
  print(table(test$verhalten))
  print(table(training$verhalten))
  
  pbar$step()
}
