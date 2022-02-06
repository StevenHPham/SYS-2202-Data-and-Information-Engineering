install.packages('ggmap','sp','maptools','maps')

yelibrary(RMySQL)
library(DBI)

library(ggplot2)
library(ggmap)
library(sp)
library(maptools)
library(maps)

attach <- dbConnect(MySQL(),
                    host = "www.awareframework.com",
                    dbname = "Pham_2848",
                    port = 3306,
                    user = "Pham_2848",
                    password  = "IlqvzyFb")