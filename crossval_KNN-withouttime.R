# readr library is used to read the csv files into console
# please check the path in the read.csv. 
# with below code we are loading the data which contains only input(features) and output(annotations) into a dataframe n
library(readr)
n <- read.csv("C:/datascience/thesis/manipulateddata/data_classification_cluster/svd/without_time/in.out/all.combined/all.csv", header = T)
# adding row names
row.names(n) <- n$y
# delete the column contatining names in this case it is 7
n <- n[,-6]
# we are subsetting the data only with the annotatio 0 or 1
# this is useful in the case we cannot replace annotations from the original ok.notok files
m <- subset(n, n$Verhalten == "0")
m1 <- subset(n, n$Verhalten == "1")
# combing both the dataframes with the annotations o and 1
k <- rbind(m,m1)
# converting the class of column verhalten from factor to numeric
k$Verhalten <- as.numeric(k$Verhalten)
library(MASS)
## verifying NA values and errors  in data
apply(k,2,function(x) sum(is.na(x)))
## normalising data between o and 1
normalisation <- function(x){(x - min(x, na.rm = T))/(max(x,na.rm = T)-min(x,na.rm = T))}
kNN <- as.data.frame(lapply(k[,1:4],normalisation))
kNN$Verhalten <- k$Verhalten
row.names(kNN) <- row.names(k)
# creating randomness in the data
set.seed(1000)
# validating the model using 10-fold cross-validation
cv.error <- NULL
l <- 10
## designing knn classifier
# loading required libraries
library(class)
library(gmodels)
# to show the status in the console while running the program
pbar <- create_progress_bar('text')
pbar$init(l)
for(i in 1:l){
  # dividing the data into two sections for training and testing the mmodel 
  # we consider 80% of the data for training and 20% for testing the model 
  index <- sample(1:nrow(kNN),round(0.80*nrow(kNN)))
  training <- kNN[index,]
  test <- kNN[-index,]
  # seperate the column with annotations to use it as the output for Neuralnetwok and the rest of the data as input
  training_labels <- training$Verhalten
  test_labels <- test$Verhalten
  # allocating annotations of training data to a dataframe c1
  c1 <- training_labels
  library(class)
  # predicting class for test data using KNN
  test_pred <- knn(train = training[,1:4], test = test[,1:4],c1, k = 1)
  library(gmodels)
  # acuracy
  print(paste(CrossTable(x = test_labels, y = test_pred, prop.chisq = F)))
  per <- sum(test$Verhalten == test_pred)
  print(paste((per/nrow(test))*100))
  
  pbar$step()
}
