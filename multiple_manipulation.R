## set directory and path for the file that contains the raw data
# use the below command in console to specify the path
# setwd("C:/datascience/TO-16017194/T-16114466/MeasurementRawData/Data_KDL1-RT23/Measurement/BSR/_CAN1")
# loading the files within the folder  
m <- list.files(pattern = "*.ame")
y <- lapply(m, function(x) read.csv(x,header = F))
names(y) <- m
# view(y[[n]]) n = 1 to no of files in the folder to have a glimpse on the data
# check view(name of the file) to have a glimpse of the data.
# removing the daa within the barackets
m1 <- lapply(y,function(x) which(x == "{"))
m2 <- lapply(y, function(x) which(x == "}"))
for(i in 1:length(y)){
  y[[i]] <- y[[i]][(m2[[i]][1]+3):(m1[[i]][2]-1),]
}
# name the columns same as the names of the raw data file 
library(splitstackshape)
y <- lapply(y, function(i) {d1 <- data.frame(text = i); cSplit(d1, 'text', '\t' )})
colnames <- c("Time(ms)", "I30(A)", "Force(N)", "Distance(mm)", "U30(v)", "ECU_state")
y <- lapply(y, setNames,colnames)
# as we do not need the column "ECU_state" we are deleting it 
z <- lapply(y, function(x) x[,-6])
# we round the time to its nearest 
k <- lapply(z, function(x) round(x[,1]))
# adding the list of the rounded time as the new row to list of dataframes
n <- Map(cbind, z, Time = k)
# removing the column time from the dataframe 
n <- lapply(n, function(x) x[,-1])
# according to the specification the test for BSR 23 degrees run for 3350ms.we filter the data according to it 
subsetting <- function(x){
  x <- subset(x,(`Time.Time(ms)` >= 0 & `Time.Time(ms)` <= 6700))
}
# n1 contains the list of files that is filtered
n1 <- lapply(n,subsetting)
# n2 contains the name of the files ad no of rows in each file 
n2 <- sapply(n1, nrow)
# n3 contains the name of the files and no of rows in each file
# cross check n2 and n3 for verification
n3 <- sapply(z,nrow)
# remove # from the below three lines of code to run it and it is only for checking the missing data
miss.data <- cbind.data.frame(m,n2)
miss.data1 <- subset(miss.data, !miss.data$n2 == 3351)
##write.csv(miss.data1,"C:/datascience/thesis/manipulateddata/missing.data/can7.csv", row.names = F)
# setwd("path name") path name to the folder to save the manipulated data
# write the data into the folder
sapply(m,function(x) write.table(n1[[x]], file = paste(x)))

