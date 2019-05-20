# readr library is used to read the csv files into console
library(readr)
# please check the path in the read.csv. as we use same program for pre-pocessing the files. 
# check the command after the header command in the read.csv that is ","  whether the data is seperated by , or ;
m1 <- read.csv("C:/datascience/thesis/manipulateddata/ok.not.ok.files/194/manipulated/CAN_6.csv", header = T,",")
# remove all the rows except the required columns
m1 <- m1[,1:4]
# filter the data that has only the temperature 23 degrees
m1 <- subset(m1,m1$Temp.gerundet..C. == 23)
# change the class of the column from factor to numeric 
m1$DataFile <- as.character(m1$DataFile)
# below commands are used to replace different classes that are already annotated, substitute all the data in which "verhalten" is empty by 1 and the remaining by 0  
m1$Verhalten <- gsub("f", "0", m1$Verhalten)
m1$Verhalten <- gsub("m", "0", m1$Verhalten)
m1$Verhalten <- gsub("e", "0", m1$Verhalten)
m1$Verhalten <- gsub("e,f", "0", m1$Verhalten)
m1$Verhalten <- gsub("n", "0", m1$Verhalten)
m1$Verhalten <- gsub("?", "0", m1$Verhalten)
m1$Verhalten <- gsub("NoBeltMovement", "0", m1$Verhalten)
m1$Verhalten <- gsub("000", "0", m1$Verhalten)
m1$Verhalten <- gsub("0,0 0", "0", m1$Verhalten)
m1$Verhalten <- gsub("0N0o0B0l0t0M0o0v000t0", "0", m1$Verhalten)
m1$Verhalten <- gsub("F0hl0r0od0?", "0", m1$Verhalten)
 m1$Verhalten <- gsub("010", "1", m1$Verhalten)
 m1$Verhalten <- gsub("0?0","0", m1$Verhalten)
 m1$Verhalten <- gsub("0,1 0","0", m1$Verhalten)
 m1$Verhalten <- gsub("1 1","0", m1$Verhalten)
# remove the symbol "#" from below command for extracting the data that is of class "0". only for TO-16017196 
# m1 <- subset(m1,m1$Verhalten == "0")
# select the data only withthe columns name of the data files and the annotations of the data 
m1 <- m1[,3:4]
# write data into csv files
write.csv(m1, "C:/datascience/thesis/manipulateddata/ok.not.ok.files/194/manipulated/CAN_6.csv", row.names = F)
