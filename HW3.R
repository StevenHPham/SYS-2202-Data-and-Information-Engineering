library(tidyverse)
library(readr)

#---Start of timestamp fix

df_timestamp <- calls$timestamp

#We need to have the results of a query return as a data frame
str(df_timestamp)

#Conversion of unit of time, set the initial time to 1970-01-01 00:00:000
time <- df_timestamp
timezone <- 0
options(digits.secs=3)

#Conversion of UNIX to human date
human_time <- data.frame(.POSIXct((time+timezone)/1000, tz="UTC"))

#---End of timestamp fix




#---Start calls edit

#importing calls.csv
calls = read_csv("Desktop/calls.csv")

#make another copy
calls_new = calls

#changing the type of calls_new from spec_tbl.df to data.frame
df = as.data.frame(calls_new)

#combining calls table with human time table into a table calls_new2
calls_new2 = cbind(df,human_time)

# Change the name of the column to DateTime 
names(calls_new2)[7] <- "DateTime"
#save the new table to a csv
write_csv(calls_new2, "calls_new2.csv")

#Plot data
library('ggplot2')
ggplot(calls_new2) + geom_point(aes(bins, call_duration))

#Binning

#Isolate DateTime column to edit
DateTime <- calls_new2$DateTime
#Bin the DateTime column into four bins
calls_new2$bins <- cut(DateTime,3, labels = c("Day 1","Day 2","Day 3"))
calls_new2


#---End of calls edit






#---Start of sensor-wifi edit
wifi = read_csv("~/Desktop/sensor_wifi.csv")


#---Start of timestamp fix

wifi_timestamp <- wifi$timestamp

#We need to have the results of a query return as a data frame
str(wifi_timestamp)

#Conversion of unit of time, set the initial time to 1970-01-01 00:00:000
time <- wifi_timestamp
timezone <- 0
options(digits.secs=3)

#Conversion of UNIX to human date
human_time <- data.frame(.POSIXct((time+timezone)/1000, tz="UTC"))

#---End of timestamp fix

#Changing timestamp to DateTime
wifi_df = as.data.frame(wifi)
wifi_new = cbind(wifi_df,human_time)

# Change the name of the column to DateTime 
names(wifi_new)[7] <- "DateTime"


#Begin omit missing bssid and ssid

#Return the column names containing NA
list_na <- colnames(wifi_new)[ apply(wifi_new, 2, anyNA) ]
list_na

# Exclude the missing observations
wifi_new_omit <-wifi_new %>%
  na.omit()		
dim(wifi_new_omit)
#wifi_new_omit now has 1147 entries as opposed to before (wifi & wifi_new) with 1203 entries

#Start of binning data into 1 hour interval

#Isolate DateTime of wifi table
wifi_DateTime <- wifi_new_omit$DateTime
#binning by hourly interval
wifi_new_omit_bin = data.frame(wifi_new_omit, cuts = cut(wifi_DateTime, breaks="1 hours", labels=FALSE))
#changing the name of the column to Hour
names(wifi_new_omit_bin)[8] <- "Hour"


ssid_count = table(wifi_new_omit_bin$ssid)
#Plotting by where wifi is used (location) and when (time)
ggplot(wifi_new_omit_bin) + geom_point(aes(Hour, ssid))
#plot before binning and removing noise
ggplot(wifi_new) + geom_point(aes(DateTime, ssid))

#Save new and edited csv
write_csv(wifi_new_omit_bin, "wifi_new_omit_bin.csv")

#---End of wifi edit





#---Start of screen edit
screen = read_csv("~/Desktop/screen.csv")


#---Start of timestamp fix

screen_timestamp <- screen$timestamp

#We need to have the results of a query return as a data frame
str(screen_timestamp)

#Conversion of unit of time, set the initial time to 1970-01-01 00:00:000
time <- screen_timestamp
timezone <- 0
options(digits.secs=3)

#Conversion of UNIX to human date
human_time <- data.frame(.POSIXct((time+timezone)/1000, tz="UTC"))

#---End of timestamp fix

#Changing timestamp to DateTime
screen_df = as.data.frame(screen)
screen_new = cbind(screen_df,human_time)

# Change the name of the column to DateTime 
names(screen_new)[5] <- "DateTime"

#Start of binning data into 1 hour interval

#Isolate DateTime of wifi table
screen_DateTime <- screen_new$DateTime
#binning by hourly interval
screen_new_bin = data.frame(screen_new, cuts = cut(screen_DateTime, breaks="1 hours", labels=FALSE))
#changing the name of the column to Hour
names(screen_new_bin)[6] <- "Hour"
screen_new_bin

#Plotting by where wifi is used (location) and when (time)
ggplot(screen_new_bin) + geom_point(aes(Hour, screen_status))

#save new and edited csv
write_csv(screen_new_bin, "screen_new_bin.csv")


