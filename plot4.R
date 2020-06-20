# File Name         plot4.R
# Developed by      Raj Kumar Pandey
# Date              20/06/2020
# Assignment        Plotting Assignment 1 for Exploratory Data Analysis 
#-------------------------------------------------------------------------------------------------------------------------------
# Loading required packages and libraries
  
#install.packages(sqldf)
#install.packages("tidyverse")
#install.packages("lubridate")
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

# Define plot parameters 
par(mfrow = c(2,2))

# Define device, set characteristics and plot
png("plot4.png", 480, 480)

plot(loadData$Date,loadData$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
plot(loadData$Date,loadData$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(loadData$Date,loadData$Sub_metering_1, type = "l", ylab = "Energy sub Metering", xlab = "")
lines(loadData$Date,loadData$Sub_metering_2, type = "l", col = "red")
lines(loadData$Date,loadData$Sub_metering_3, type = "l", col = "blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), box.col = "white", lty = 1, lwd = 1, cex = 0.7)
plot(loadData$Date,loadData$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime", cex.axis = 0.9)

# set the device off and back to the default screen device
dev.off()