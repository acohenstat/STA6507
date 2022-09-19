#This code is to show how to use R to construct bootstrap CI.

# Package needed 
#install.packages("boot")
library(boot)

# Create a function f in R to compute the observed statistic
myf=function(df,i){
  stat=mean(df[i,])
  return(stat)
}

# generate data from standard normal distribution 
mydata=data.frame(x=rnorm(10))
# we know the mean of the population is zero
# theoretical CI
UB= mean(mydata$x) + qnorm(0.975)/sqrt(nrow(mydata))
LB= mean(mydata$x) - qnorm(0.975)/sqrt(nrow(mydata))

c(LB,UB)

# bootstrapping with R replications 

results = boot(mydata, myf , R = 1000)

# get conf% confidence interval 
resci = boot.ci(results, conf = 0.95, type="all")

hist(results$t,freq = F)
lines(density(results$t),col="red")

# Air Quality
data("airquality")
df = airquality %>% 
   select(Wind)

results = boot(df, myf , R = 100000)

# get conf% confidence interval 
boot.ci(results, conf = 0.95, type="all")


# Example showing how to plotting a theoretical distribution (e.g. Chi-square with 3 degrees of freedom) 
# and observations randomly generated from the same distribution
# We used this example to show how the empirical distribution is different from the true distribution

# Histogram
hist(rchisq(1000000,3),freq = FALSE, nclass = sqrt(1000000),ylim = c(0,0.4))
# Add the curve the density distribution function on the top of the histogram
lines(seq(0,15, by = 0.001),dchisq(seq(0,15, by = 0.001) ,df = 3), type="l", col="red")

