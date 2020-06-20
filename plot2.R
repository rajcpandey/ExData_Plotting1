# File Name         plot2.R
# Developed by      Raj Kumar Pandey
# Date              20/06/2020
# Assignment        Plotting Assignment 1 for Exploratory Data Analysis 
#-------------------------------------------------------------------------------------------------------------------------------
# Loading required packages and libraries
  
#install.packages(sqldf)
#install.packages("tidyverse")
install.packages("lubridate")
library(sqldf)
library(tidyverse)
library(lubridate)

  
# convert file to csv format so that we can use it with read.csv.sql function and only select the rows we want
# We have only one file in the working directory

files <- list.files(pattern="*.txt")
newfiles <- gsub(".txt$", ".csv", files)
file.rename(files, newfiles)


# Read on selected data from the txt file
loadData <- read.csv2.sql("household_power_consumption.csv", sql = "select * from file where Date IN ('1/2/2007','2/2/2007')")


#Convert the date and time from character to proper date and time
loadData <- loadData %>%  mutate(Date = as.Date(Date, format = "%d/%m/%Y"))
loadData <- loadData %>%  mutate(Date=paste(Date, Time) %>% as.POSIXct(., format="%Y-%m-%d %H:%M"))

# Define device, set characteristics and plot
png("plot2.png", 480, 480)

plot(loadData$Date,loadData$Global_active_power, type = "l", ylab = "Global Active Power (Kilowatts)", xlab = "")

# set the device off and back to the default screen device
dev.off()