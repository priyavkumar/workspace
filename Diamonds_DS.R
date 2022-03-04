##### ************************************************************
####                Diamond Dataset
##### ************************************************************

##### -----------Install Libabry-----------------
install.packages("magrittr") # package installations are only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)    # alternatively, this also loads %>%

library(ggplot2)


##### -----------Check current folder-----------------
#getwd()
#list.files()

##### -----------Load library-------------------------
library(ggplot2)


##### -----------Load Dataset-------------------------

data("diamonds")

names(diamonds)

diamonds$color

#?diamonds
is.ordered(diamonds$color)
sum(sapply(diamonds,is.ordered))

# Create a histogram of the price of
# all the diamonds in the diamond data set.

#ggplot(data = diamonds , aes(x=price)) + geom_histogram(binwidth = 30,color = I('blue'), fill = I('#F79420')) +
#  xlab('Price of the Diamonds') +
#  ylab('Number of Diamonds') + scale_x_continuous(limits = c(0,20000))

#qplot(x=price,data = diamonds, color = I('blue'), fill= I('#F79420')) +
 # geom_histogram(binwidth = 30) + 
  #scale_x_continuous(limits = c(0,20000) , breaks = seq(0, 1000, 500))

qplot(x=price,data = diamonds, color = I('blue'), fill= I('#F79420')) +
  geom_histogram(binwidth = 5, color = 'blue',fill= "black") +
  scale_x_continuous(limits = c(0,20000), breaks = seq(0, 20000,1000))

qplot( data = diamonds, x = price, binwidth = 15, color = I('coral') , fill = I('blue')) +
  scale_x_continuous(limits = c(0,20000), breaks = seq(0, 20000,1000)) + facet_wrap(~cut, ncol = 3)

# Log transformation using scale_xx()

qplot( data = diamonds, x = price, color = 'blue') + 
  scale_x_continuous(limits = c(0,20000), breaks = seq(0, 20000,1000)) + 
  scale_x_log10() + stat_bin(bins = 30)

ggplot(data=diamonds) + geom_histogram(binwidth = 300, aes(x=price), color = 'blue', fill = 'red') + 
  scale_x_continuous(limits = c(0,10000), breaks = seq(0,10000,500))+ 
  ggtitle("Diamond Price Distribution") + 
  xlab ("Diamond Price in US Dollars") + 
  ylab("Frequency") + theme_classic() 
ggsave('DiamondsPriceDistribution.jpeg')


#####================Summary of the Dataset========================

summary(diamonds)
mean(diamonds$price)
median(diamonds$price)

#=====================Diamonds Count per Cost======================

diamonds %>%
  filter(price < 500) %>%
  summarise(n = n())

diamonds %>%
  filter(price < 250) %>%
  summarise(n = n())

diamonds %>%
  filter(price >= 15000) %>%
  summarise(n = n())
#===========================ggsave()==========================================================================

ggplot(diamonds, aes(x = price)) + 
  geom_histogram(color = "black", fill = "DarkOrange", binwidth = 100) + 
  scale_x_continuous(breaks = seq(0, 5000, 100)) + 
  theme(axis.text.x = element_text(angle = 90)) + 
  coord_cartesian(c(0,5000)) +
  xlab("Price") + ylab("Count") 
ggsave('priceHistogram2.png') ### donot add + sign. ggsave is not part of plot anymore.

#============histogram of diamond prices by cut====================================================================

qplot( data = diamonds, x = price, binwidth = 15, color = I('coral') , fill = I('blue')) +
  scale_x_continuous(limits = c(0,20000), breaks = seq(0, 20000,1000)) + facet_wrap(~cut, nrow = 3)

qplot(x = price, data = diamonds) + facet_wrap(~cut, scales = "free")



diamonds %>%
  group_by(cut) %>%
  summarise(max_price = max(price),
            min_price = min(price),
            median_price = median(price))

by(diamonds$price,diamonds$cut, summary) #best practice

#============Price per Carat by Cut==============================================================================

ggplot(data = diamonds, aes(x = diamonds$price/diamonds$carat)) + 
  geom_histogram(color = "black", fill = "DarkOrange", binwidth = 0.05) +
  scale_x_log10() + facet_wrap(~cut , scales = "free") + 
  ggtitle("Diamond Price per Carat Distribution by Cut") +
  xlab("Diamond Price per Carat U$") 

#============BOXPLOTS BY CLARITY, BOXPLOT BY COLOR, or BOXPLOTS BY CUT==========================================

ggplot(data = diamonds, aes(x = diamonds$clarity, y = diamonds$price, color = cut)) +
  geom_boxplot() + facet_grid(~color)
  ggsave('priceclaritycut.pdf')


#=====================Interquartile Range - IQR==================================================================
  
  
  #What is the price range for the middle 50% of diamonds with color D (best color)?
  #What is the price range for the middle 50% of diamonds with color J (worst color)?
  #What is the IQR for diamonds with the best color (color D)?
  #What is the IQR for diamonds with the worst color (color J)?
  
IQR(subset(diamonds, price <1000)$price)
  
d = subset(diamonds, diamonds$color == 'D')
j = subset(diamonds, diamonds$color == 'J')

summary(d)
summary(j)



levels(diamonds$color)
class(diamonds$color)
IQR(diamonds$price[diamonds$color == 'D'])
IQR(diamonds$price[diamonds$color == 'J'])

# Investigate the price per carat of diamonds across
# the different colors of diamonds using boxplots.

#=====================Price per Carat Box Plots by Color==================================================================
#diamonds$carat
#diamonds$price
#levels(diamonds$carat)
#ggplot(diamonds) + 
#  geom_boxplot(mapping = aes(x= diamonds$price, y = diamonds$carat, fill = color,na.rm = TRUE ,  )) + facet_grid(~color)

ggplot(diamonds) + geom_boxplot(mapping = aes(x= color, y = price/carat, fill = color), na.rm = TRUE) +
  ggtitle("Price per Carat Box Plots by Color") + xlab("Color") + ylab(" Price per Carat") + coord_cartesian(ylim = c(0,7500)) + 
  scale_y_continuous(breaks = seq(0,7500,500))


#ggplot(data = diamonds) + geom_boxplot(mapping = aes(x = clarity, y = price, color = clarity, fill = clarity, alpha = 0.01)) + coord_flip() + ggtitle("BOXPLOT BY CLARITY")

#=====================Carat Frequency Polygon==================================================================

qplot(data = diamonds, x = carat, ylab = 'Frequency', binwidth = 0.1, geom = 'freqpoly') +
  scale_x_continuous(breaks=seq(0,5,0.1)) + scale_y_continuous(breaks=seq(0,12000,2000))









