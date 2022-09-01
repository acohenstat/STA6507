# Library / package
library(datasets)
library(tidyverse)

# This is my comment 
# run a regression...

# Calculator 
# This is to show how we can run R
x=10^2
y=2*x
s = "Hello Everyone"

x <- 5
x = 10

5 -> y

# Vectors
vec1=c(1,21,50,80,45,0)
vec2=c("d","4","r")

#functions
sum(vec1)
help(sd)
example(sum)



sum(vec1)
mean(vec1)
sd(vec1)
summary(vec1)
var(vec1)

# Sequence Vectors
vec3 = 100:10
seq(from=1,to=10,by=5)
seq(1,5,10)
seq(1,10,0.5)
seq(10,1)

# Vector Access
vec1[1] = 5
vec1[c(2,5,6)]
vec1[1:3]

# Named vector
r=c(1:3)
names(r) = c("f","s","t")
r[5]=2
barplot(r)


# Matrices
ma1 = matrix(data = vec1,nrow = 4)
ma1
# Data frames
t=data.frame(x=rnorm(100),y=rnorm(100,mean = 5))

summary(airquality)
x=t$x
y=t$y

# R Datasets
mdata=cars

# Reading variables from a data.frame
with(mdata,mean(speed+dist))
mean(mdata$speed+mdata$dist)
with(mdata,plot(speed))
 
attach(cars)

# Structure and Summary
str(mdata)
summary(mdata)
print(mdata)
View(mdata)

# Creating new variables 
mdata$time=mdata$dist/mdata$speed

mdata$speed2=mdata$speed^2

# Rename the variables 
library(reshape)
mdata=rename(mdata,c("speed"="mspeed", "speed2"="s2"))
colnames(mdata)
`colnames<-`(mdata,c(""))
mydata=`colnames<-`(mdata,c("s"))

# Create categories from continuous variable
mdata$newdata= (mdata$mspeed >=5) + (mdata$mspeed >=10) + (mdata$mspeed >=15)  +(mdata$mspeed >=20) 
#mdata$ndata= cut(mdata$mspeed, breaks = c(4,5,10), labels = c("cut0","cut1"), right = FALSE)

mdata$newdata = as.factor(mdata$newdata)

# Creating factors
x=c(0,0,1,1,2)
x=factor(x,labels = c("Control","Low Dose","High Dose"))


babynames$year =  as.factor(babynames$year)
# Drop or keep variables in a data set
library(datasets)
library(carData)
mdata=Salaries

submdata=subset(mdata,select = c("discipline","salary"))
submdata1=mdata[1:100,c(1:4)]
submdata2=subset(mdata,select = c(-2,-3))

# Keep Unique values
uni=unique(mdata)

# Identify duplicated values
dup=duplicated(mdata)

# stack datasets
newdata=cbind(rnorm(50),rnorm(50))
rb=rbind(rnorm(100),rnorm(100))


# Probability distributions
mdata=rnorm(n=30,mean = 5,sd = 1.5)
hist(mdata,freq = FALSE)
plot(mdata,
     type="o",
     col="red",
     xlab = "Number from Normal",
     ylab = "Values", 
     main = "10000 Obs. from Standard Normal Dist.")

dt=rnorm(10000,mean=10,sd=3)
var(dt)
quantile(dt,c(0.25,0.5,0.75,0.99))
quantile(dt,0.66)


library(moments)
skewness(dt)
kurtosis(dt)


hist(dt)
hist(scale(dt))

# Probability distributions
x=rnorm(100,mean=1,sd = 1)
xp=pnorm(1.96,mean=0,sd=1)
pbinom(2,size = 10,prob = 0.5,lower.tail = F)
qnorm(0.975)
## Density function
dnorm(0) # no a probability
dbinom(5,size = 10,prob = 0.5)

set.seed(1)
x=runif(10,min = 0,max = 1)
x2=rnorm(10)

x3=rnorm(10)
rexp(10,rate = 1)


# Useful functions
min(rnorm(100))
max(rnorm(100))
abs(rnorm(100))
sqrt(abs(rnorm(100)))
2**9
2^9
exp(1)
log(1)
log10(10)
log2(2)
log(45,base = 45)

factorial(3)
choose(10,5)



#####################################
# Conditional Execution
# 'if', 'for' and 'while' statements

h=26
if(h<=21){
  
  print("happy")
  
}else{
  
  print("sad")
}

#Example: tenure criterion
# Number of publications 
n = 6
publications.vec  = rnorm(n,mean=15,sd=4)
publications.vec
# round to nearest integer
publications = round(publications.vec,0)
publications

dt=data.frame(1:n,publications,rep(NA,times=n))
dt

colnames(dt) = c("ID","Publications","Decision")
dt

# suppose tenure is only given to those with 15 or more
for(i in 1:n){
  if(dt[i,2] < 15)
  {dt[i,3]=c("nottenured")}
  else{dt[i,3]=c("tenured")};
  
}

dt

