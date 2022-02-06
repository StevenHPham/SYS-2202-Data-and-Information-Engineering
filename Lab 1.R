library(tidyverse)
library(readxl)

url1 = "https://raw.githubusercontent.com/mdporter/SYS2202/master/data/offers1.csv"
(my_lines  = read_lines(url1))
my_file = read_file(url1)

url3 = "https://raw.githubusercontent.com/mdporter/SYS2202/master/data/offers3.csv"
my_lines2 = read_lines(url3)

my_table = read_csv(url3, skip=2, n_max=9)

url4 = "https://raw.githubusercontent.com/mdporter/SYS2202/master/data/offers4.csv"
my_table4 = read_csv(url4, col_types = "??????") #specify the column types to be characters for 5 columns 

my_table5 = read_csv(url4, col_types =
                            cols(name="c", company="c", jobtype="c", location="c",
                            salary="n", # number column 
                            date = col_date("%d-%m-%Y"))) # date column
my_table5

#mutate can be used to modify column types


