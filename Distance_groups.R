library(readr)
m <- read.csv("C:/datascience/thesis/manipulateddata/maniplateddata/194/CAN_1/KDL1-RT23_A05_CAN1_000072.ame",header = T," ")
m1 <- read.csv("C:/datascience/thesis/manipulateddata/maniplateddata/194/CAN_1/KDL1-RT23_A05_CAN1_000124.ame",header = T," ")
m2 <- read.csv("C:/datascience/thesis/manipulateddata/maniplateddata/194/CAN_1/KDL1-RT23_A05_CAN1_000566.ame",header = T," ")
m3 <- read.csv("C:/datascience/thesis/manipulateddata/maniplateddata/194/CAN_1/KDL1-RT23_A05_CAN1_000011.ame",header = T," ")
n <- cbind(m$Distance.mm.,m1$Distance.mm.,m2$Distance.mm.,m3$Distance.mm.,m$Time.Time.ms.)
colnames(n) <- c("Tooth to Tooth", "Bsr Too Long", "Tooth to Tooth and BSR Too Long", "Ideal","Time")
n <- as.data.frame(n)
library(ggplot2)
ggplot(n,aes(Time, y = value, color = variable))+
  geom_line(aes(y = n$`Tooth to Tooth`, col = "Tooth to Tooth")) +
  geom_line(aes(y = n$`Bsr Too Long`, col = "Bsr Too Long"))+
  geom_line(aes(y = n$`Tooth to Tooth and BSR Too Long`, col = "Tooth to Tooth and BSR Too Long"))+
  geom_line(aes(y = n$Ideal, col = "Ideal"))+
  ggtitle("Distance") +
   theme(text = element_text(size=17), plot.title = element_text(hjust = 0.5))
  theme(plot.title = element_text(hjust = -0.45, vjust=2.12)))
