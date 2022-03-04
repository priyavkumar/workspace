getwd()
setwd("~/Personal/Family Folders/Priya/R Programming/Udacity/EDA/dataset")
list.files()
pf <- read.csv('pseudo_facebook.tsv' , sep = '\t')
names(pf)
#Histogram of users' Birthday
library(ggplot2)
#ggplot(data = pf , aes(x = dob_day)) + geom_histogram(binwidth = 1) + scale_x_continuous(breaks = 1:31)
#ggplot(data = pf , aes(x = dob_day)) + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 90, size = 10))
#install.packages("plotly")                            # Install plotly package
#library("plotly") 
ggplot(data = pf , aes(x = dob_day)) + geom_bar() + scale_x_continuous(breaks = 1:31)
#ggplot(data = pf , aes(x = dob_day, y = count.fields(dob_day), filled.contour(color.palette = "viridis" ))) + geom_bar(stat = "identity",fill = "steelblue"  ) + scale_x_continuous(breaks = 1:31)
install.packages("viridis")  # Install
library("viridis")           # Load
ggplot(data = pf , aes(x = dob_day)) + geom_bar() + scale_x_continuous(breaks = 1:31) + facet_wrap(~dob_month, ncol = 3)
#ggplot(data = pf , aes(x = friend_count )) + geom_histogram(binwidth = 1)
#qplot(x = friend_count,data = pf , xlim = c(0,1000) )
#qplot(x = friend_count,data = pf) + scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50))+facet_grid(~gender)
#Eliminate NA from friends count
qplot(x = friend_count,data = subset(pf,!is.na(gender))) + scale_x_continuous(limits = c(0,1000), breaks = seq(0,1000,50))+facet_grid(~gender)
#statistic by Gender
table(pf$gender)
#summary of friend count by gender. we can find it using by().
by(pf$friend_count,pf$gender,summary)
ggplot(aes(x = tenure/365), data = pf) +
  geom_histogram(binwidth = .25, color = 'black', fill = '#F79420') + 
  xlab('Number of years using Facebook') +
  ylab('Number of users in sample') +
  scale_x_continuous(breaks = seq(1,7,1), lim = c(0,7))

#*******************************************************************
#                            USER AGE
#*******************************************************************
ggplot(data=pf, aes(x = age)) +
    geom_histogram(binwidth = 1, color = 'black',fill= '#5760AB') +
    scale_x_continuous(breaks = seq(0,120,5)) +
    xlab('Age of the Users') +
    ylab('No of Users in sample')
#Transforming Data
summary(log10(pf$friend_count + 1))
summary(sqrt(pf$friend_count))
install.packages('gridExtra')
library(gridExtra)
#plot in multiplot in 1 graph
#p1 = ggplot(data = pf , aes(x = friend_count )) + geom_histogram(binwidth = 1)
p1 = qplot(x = friend_count,data = subset(pf,!is.na(gender)))
p2 = summary(log10(pf$friend_count + 1))
p3 = summary(sqrt(pf$friend_count))
myList <- list(ggplotGrob(p1), ggplotGrob(p2), ggplotGrob(p3))
grid.arrange(grobs = list(p1,p2,p3), ncol = 2 )
