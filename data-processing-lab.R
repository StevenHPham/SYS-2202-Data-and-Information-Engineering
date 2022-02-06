#install.packages("TTR")
library("TTR")
#install.packages("smoother")
library("smoother")
library("ggplot2")
library("gcookbook")
data("heightweight")

heightweight = heightweight[order(heightweight$heightIn),]

P = ggplot(heightweight) + geom_line(aes(heightIn, weightLb))
P

#smth simple moving average ?smth
ys_sma = smth(heightweight$weightLb, method = 'sma')
P + geom_line(aes(heightweight$heightIn, ys_sma, col = "red"), size=1.3)
#> Warning: Removed 9 rows containing missing values (geom_path).

no_data_in_bins = 5
ys_bin = round(ave(heightweight$weightLb,
                   rep(1:length(heightweight$weightLb), each = no_data_in_bins, length.out =
                         length(heightweight$weightLb))))
P + geom_line(aes(heightweight$heightIn, ys_bin, col = "red"), size=1.3)
P
library(tidyverse)

data(package="tidyr")
# table1, table2, table3, table4a, table4b
table1
?mutate
table1 %>% mutate(rate=cases/population)

#Same as line 31
table1_copy = table1
mutate(table1, rate=cases/population)

#gather
tidy4a = gather(table4a, key="year", value="cases",2:3)
tidy4a

tidy4b = gather(table4b, key="year", value="population", 2:3)
tidy4b

#spread
table2
unique(table2$type) #unique gives number of distinct variable 
spread(table2, key=type, value=count)

#Seperate
table3_new
table3_new = separate(table3, rate, into=c("cases", "population"), sep="/",convert=TRUE)
table3_new
mutate(table3_new, rate=cases/population)
?separate

url = "https://raw.githubusercontent.com/mdporter/SYS2202/master/data/date-event.csv"

df = read_csv(url)
df
separate(df, col=date, into=c("year", "month", "day"), sep="-")

separate(df, col=date, into=c("year", "month", "day"), sep="-",
         remove=FALSE, convert=TRUE)


df %>%
  separate(col=date, into=c("year", "month", "day"), sep="-",
           remove=FALSE, convert=TRUE) %>%
  unite(col="USdate", month, day, year, sep="/")

df %>%
  separate(col=date, into=c("year", "month", "day"), sep="-",
           remove=FALSE, convert=TRUE) %>%
  count(day, event) %>%
  complete(day=1:31, event=c('A','B', 'C', 'D'), fill=list(n=0L))

