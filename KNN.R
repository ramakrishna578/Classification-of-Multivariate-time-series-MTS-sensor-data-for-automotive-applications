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
# adding the names of the datafiles as row names
row.names(kNN) <- row.names(k)
# creating randomness in the data
## designing knn classifier
set.seed(1000)
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
test_pred <- knn(train = training[,1:4], test = test[,1:4],c1, k = 5)
library(gmodels)
# accuracy
CrossTable(x = test_labels, y = test_pred, prop.chisq = F)
per <- sum(test$Verhalten == test_pred)
print(paste((per/nrow(test))*100))
tp <- sum(test_labels == 3 & test_pred == 3)
tn <- sum(test_labels == 1 & test_pred == 1)
fn <- sum(test_labels == 1 & test_pred == 3)
fp <- sum(test_labels == 3 & test_pred == 1)
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
# true positive rate
tpr <- tp/(tp+fn)
print(tpr)
# false positive rate
fpr <- fp/(fp+tn)
print(fpr)
