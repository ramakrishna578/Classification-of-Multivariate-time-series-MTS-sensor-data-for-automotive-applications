
# readr library is used to read the csv files into console
library(readr)
# please check the path in the read.csv. as we use same program for pre-pocessing the files.
# with below code we are loading the input data which contains only features into a dataframe n
n <- read.csv("C:/datascience/thesis/manipulateddata/data_classification_cluster/svd/only_in/not.ok_196.csv", header = T)
# with below command we are loading the data with annotations to add as output to the data with features
# please check whether we are adding respective output file to input dile
# we load the output file to the dataframe m
# in case of BSR pc1,2,3,4 from both Test orders we consider all the data as not ok class so we add the Verhalten column as class 0
m <- read.csv("C:/datascience/thesis/manipulateddata/ok.not.ok.files/196/manipulated/CAN6.csv", header = T) 
# as the names of the data file in the input and the annotated file are different we add .ame to the the annotated file to make it similar to the names of input file
# for the files from pc1,2,3,4 of BSR no need to add the extension ".ame" 
m$a <- "ame"
m$X <- paste0(m$DataFile,'.',m$a)
# as we need only the columns with names of the datafile and verhalten we delete other columns
m <- m[,c(2,4)]
# we merge the input file with the annotation file based on the name of the datafile
# then we obtain a single file that contains both the input and output
k <- merge(m,n)
# as we do not have sufficient data we considered the data from BSR Pc1, 2, 3, 4 as the not ok files so we load them into 
# dataframe n and add the annotations as "0" directly as we do not consider the ok.not ok file for PC1,2,3,4
# remove # from below code and use the code only for BSR pc1,2,3,4 files from both test orders to add annotation
#n$verhalten <- 0
# writing  the dataframe into csv
# please be caution that in below code for all the files it is dataframe"k" and for only data from PC1,2,3,4 it is dataframe n
write.csv(n,"C:/datascience/thesis/manipulateddata/data_classification_cluster/svd/in.out/not.ok_196.csv", row.names = F)

