#This code is to show how to use R to construct bootstrap CI.

# Package needed 
library(boot)

# Create a function f in R to compute the observed statistic
myf=function(DATA,i){
  d = DATA[i,]
  stat=median(d)
  return(stat)
}



mydata=data.frame(x=rnorm(10))


# bootstrapping with R replications 
results = boot(mydata, myf , R = 2000)
# get conf% confidence interval 
boot.ci(results, conf = 0.95, type="all")


hist(results$t,freq = F)
lines(density(results$t),col="red")




# Example showing how to plotting a theoretical distribution (e.g. Chi-square with 3 degrees of freedom) 
# and observations randomly generated from the same distribution
# We used this example to show how the empirical distribution is different from the true distribution

# Histogram
hist(rchisq(100000,3),freq = FALSE, nclass = sqrt(100000),ylim = c(0,0.4))
# Add the curve the density distrubtion function on the top of the histogram
lines(seq(0,15, by = 0.001),dchisq(seq(0,15, by = 0.001) ,df = 3), type="l", col="blue")

