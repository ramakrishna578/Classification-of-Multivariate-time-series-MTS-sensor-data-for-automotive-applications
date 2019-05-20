library(readr)
n <- read_csv("C:/datascience/thesis/manipulateddata/graphs/precision,recall.ame")
n <- as.data.frame(n)
n$X1 <- as.factor(n$X1)
#n$Precision <- as.factor(n$Precision)
n <- n[-4,]
n$Precision <- n$Precision*100
n$Recall <- n$Recall*100
n$`F-measure` <- n$`F-measure`*100
n$Sensitivity <- n$Sensitivity*100
n$Specificity <- n$Specificity*100
library(tidyr)
n.tidy <- n %>%
gather(Key,Value,-Model) %>%
separate(Key, c("Performance Criteria", "Measure"), "\\." )
n.tidy <- n.tidy[,-3]
n.tidy$Model <- as.factor(n.tidy$Model)
n.tidy$`Performance Criteria` <- as.factor(n.tidy$`Performance Criteria`)
n <- as.data.frame(n)
row.names(n) <- n$X1
n <- n[,-1]
barplot(as.matrix(n), beside = T, col = c("red","blue","black","forest green","gold","yellow"),ylim = c(94,100),xpd = F,main = "Performance Evaluation")
box()
axis(side = 2,at=94:100)
legend("topleft",fill=c("red","blue","black","forest green","gold","yellow"))
library(ggplot2)
p <- ggplot(n.tidy, aes(x = `Performance Criteria`, y = Value, color = `Performance Criteria`))+
  geom_col()+
facet_grid(. ~ Model)
p + ggtitle("Performance Measure")
p + coord_cartesian(ylim=c(94, 100))
p + theme(text = element_text(size=10),
          axis.text.x = element_text(angle=45))


