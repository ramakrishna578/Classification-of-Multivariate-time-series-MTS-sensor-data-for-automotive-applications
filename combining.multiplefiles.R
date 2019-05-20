# we combine the multiple files to one file that contains both the input and output(annotations)
# please check the path while loading the files
# first combine data from different channels CAN1,2,3,4,5,6 of each test order and not ok files seperately
# then combine all the files from the test orders and not ok files into one single file
load_data <- function(path){
  files <- dir("C:/datascience/thesis/manipulateddata/data_classification_cluster/svd/without_time/in.out/all.combined",pattern = '\\.csv', full.names = T)
  tables <- lapply(files,read.csv)
  do.call(rbind,tables)
}
m <- load_data("all.combined")
# adding the extension last 3 digits of the TO number to diffrentiate the data
m$a <- 196
m$y <- paste0(m$X,'.',m$a)
m$y <- m$X
# remove unwanted columns
m <- m[,-8]
m<- m[,-1]
m <- m[,-14]
# adding the column with extension as the row names of the dataframe
row.names(m) <- m$x
# remove the unwanted rows
m <- m[,-14]
# writing data into one single file that contains both the input and the output
write.csv(m,"C:/datascience/thesis/manipulateddata/data_classification_cluster/svd/without_time/in.out/all.combined/all.csv", row.names = F)
