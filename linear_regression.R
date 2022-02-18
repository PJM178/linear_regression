# Multivariate linear regression
# Petri Montonen 2022

# Loading the necessary packages and data

library(ggplot2)
library(tidyr)
library(dplyr)
library(ggrepel)
library(tidyquant)
library(fPortfolio)
library(PerformanceAnalytics)
library(quadprog)
library(scales)
library(mltools)
library(data.table)
library(corrplot)
library(PerformanceAnalytics)
library(RColorBrewer)
library(car)
library(lmtest)
library(readxl)
library(carData)
library(tsoutliers)
library(gvlma)
library(vars)
library(Hmisc)
library(tseries)
library(strucchange)
library(gap)

rm(list=ls())
setwd("C:/Users/petri/Desktop/GitHub töitä/R/Linear_regression")

data('mtcars')

any(is.na(mtcars))

str(mtcars)
summary(mtcars)

# correlation analysis

par(mfrow=c(1,1))
corrplot(cor(mtcars), type = "upper", order = "hclust", col = brewer.pal(n = 8, name = "RdYlBu"))
chart.Correlation(mtcars, histogram = TRUE)

# Visualizing the variables - high correlation clear

ggplot(mtcars, aes(wt, mpg)) +
  geom_point() +
  scale_x_continuous(breaks = seq(0,13)) +
  scale_y_continuous(n.breaks = 20)

# linear regression model

model = lm(mpg~cyl+disp+hp+drat+wt+qsec+vs+am+gear+carb, data=mtcars)
summary(model)

# model without cyl, drat, vs, gear and carb

model2 = lm(mpg~disp+hp+wt+qsec+am, data=mtcars)
summary(model2)

# model without disp and hp

model3 = lm(mpg~wt+qsec+am, data=mtcars)
summary(model3)

# fitted vs original values plotted

colors <- c("Original" = "blue", "Fitted" = "red")

df = data.frame(Observation = seq(from = 1, to = 32, by = 1), Original = mtcars$mpg, Fitted = fitted.values(model3))

ggplot(df, aes(x = Observation, color = Observation)) +
  geom_point(aes(y = Original, color = "Original")) +
  geom_line(aes(y = Original, color = "Original")) +
  geom_point(aes(y = Fitted, color = "Fitted")) +
  geom_line(aes(y = Fitted, color = "Fitted")) +
  labs(y = "Miles per gallon (mpg)") +
  scale_color_manual(values = colors) +
  theme(legend.position = c(0.061,0.955), legend.title = element_blank(), legend.background = element_rect(fill = alpha("lightgrey", 0)))

# multicollinearity test

vif(model3)

# statistical tests for BLUE

# Assumption 2 - variance of the errors is constant
# plot
par(mfrow=c(2,3))
plot(model3, id.n = 0)
#GQ-test
gqtest(model3)
bptest(model3)

# Assumption 3 - no autocorrelation
par(mfrow=c(1,2))
resl=c(0,head(model3$residuals,-1))
plot(resl,model3$residuals,main="Lagged against unlagged")
acf(model3$residuals,main="Autocorrelation Function")
#Durbin-Watson test
durbinWatsonTest(model3)
bgtest(model3,order=4)

# Assumption 4 - no relationship between errors and corresponding variable
cor.test(mtcars$am, model3$residuals)
cor.test(mtcars$wt, model3$residuals)
cor.test(mtcars$qsec, model3$residuals)
plot(mtcars$am, model3$residuals)
plot(mtcars$wt, model3$residuals)
plot(mtcars$qsec, model3$residuals)

#Assumption 5 - normality of residuals
JarqueBera.test(model3$residuals)
jarque.bera.test(model3$residuals)
hist(model3$residuals,main="")
plot(model3,2)

#Multicollinearity
cor4=data.matrix(model3$residuals)
cor(cor4)

#vif(task1)
vif(model3)

#adopting wrong functional form
resettest(model3)

#parameter stability test
split = length(mtcars$mpg)/2
mtcarsh = head(mtcars, split)
mtcarst = tail(mtcars, split)
chow.test(mtcarsh$mpg, matrix(c(mtcarsh$wt,mtcarsh$qsec,mtcarsh$am), byrow = FALSE, ncol = 3), mtcarst$mpg, matrix(c(mtcarst$wt,mtcarst$qsec,mtcarst$am), byrow = FALSE, ncol = 3))
