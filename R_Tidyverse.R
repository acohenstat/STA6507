# R Tidyverse script UWF - acohen@uwf.edu
# *****************************************************

# Tidyverse
install.packages("tidyverse")
library(tidyverse)
# dplyr: manipulating data.frame
# purrr: working with functions
# ggplot2: visualization

# data packages
install.packages("dslabs")
library(dslabs)


# Tidy data
# Each row represents one observation and columns represent variables.
data(relig_income)
data(ChickWeight)

relig_income_tidy = pivot_longer(relig_income,cols = -religion, 
                                 names_to = "income",
                                 values_to = "counts") 


# Working with Data.frame
# add a variable/column 
murders = mutate(murders, rate=total/population*100000)

# Sub setting with filter
filter(murders, rate < 1 & region == "North Central")


# Select: pick variables
new_table = select(murders, state, region, rate)
filter(new_table, rate <1)


# The pipe operator %>%
# With dplyr we can do a series of operations, for example select and then filter 
# using the pipe operator

murders %>% select(abb,region,rate) %>% filter(rate<0.7)

murders %>% select(region, rate) %>% filter(rate <0.7)

relig_income_tidy %>% select(income)

25 %>% sqrt() %>% log2()
log2(sqrt(25))


## summarizing data
data(heights)

# computes the average and standard deviation for females:

avg_sd = heights %>% filter(sex=="Female") %>%
  summarise(avg=mean(height),sdt=sd(height))

avg_sd


heights %>% 
  filter(sex == "Female") %>%
  summarize(rg = quantile(height, c(0, 0.5, 1)),
            avg=mean(height),
            sdt=sd(height))


# Let's compute the murder rate of the USA
# Recall that the USA murder rate is not the average of the state murder rates

avg_state_rates = murders %>% summarise(mean(rate)) %>% pull()

US.murder.rate = murders %>% summarise(rateUSA=sum(total)/sum(population)*100000)

# Looking at the results they are data.frame even if it is just one number
murders %>% summarise(rate=sum(total)/sum(population)*100000) %>%
  pull(rate)


## Data Grouping
heights %>% group_by(sex)
# tibble: many tables same columns but not necessarily the same number of rows

heights %>% group_by(sex) %>% summarise(avg= mean(height),std=sd(height))

# let's compute the median murder rate in the four regions of the country:
murders %>% group_by(region) %>% summarise(median.rate=median(rate))  


## Arrange data frame 
murders %>% arrange(desc(rate))

murders %>% 
  arrange(population) %>%
  head()

murders %>% top_n(10)


## purrr : apply functions
# apply the same function to each element of a vector 
compute_s_n=function(n){
  sum((1:n))
}
nvalues=c(3,5,10,15,200)
s_n = map_dbl(nvalues, compute_s_n) 

mtcars %>%
  split(.$cyl) %>% # from base R
  map(~ lm(mpg ~ wt, data= .x)) %>%
  map(summary) %>%
  map_dbl("r.squared")

mtcars %>% ggplot(aes(y=mpg,x=wt)) + geom_point() + 
  geom_smooth(method="lm") + facet_wrap(~cyl)


# This is not going to work because the output of group_by is a tibble
mtcars %>% group_by(cyl) %>% map(~ lm(mpg ~ wt, data=.x))

# This works 
mtcars %>%
  group_by(cyl) %>%
  group_map(~ lm(mpg ~ wt, data=.x))%>%
  map(summary) %>%
  map_dbl("r.squared")


## ************** ggplot2 *******************
# data visualization
library(ggthemes)
library(ggrepel)

ggplot(murders)
murders %>% ggplot()

murders %>% ggplot(aes(x=population/10^6,y=total)) 


ggplot1 = murders %>% ggplot(mapping = aes(x=population/10^6, y=total)) 
ggplot1

  ggplot1 + geom_point(aes(col=region), size = 4) +
  geom_text_repel(aes(label=abb)) +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(formula = "y~x", method=lm,se = F)+
  xlab("Populations in millions (log10 scale)") + 
  ylab("Total number of murders (log10 scale)") +
  ggtitle("US Gun Murders in 2010") +
  scale_color_discrete(name = "Region")+
      theme_wsj()

