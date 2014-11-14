#Exploratory Data Analysis - Project #1

#read data file into R and assign to variable the variable 'data'

setwd("c:/Users/Nathan/Documents/Coursera/Data Science/4. Exploratory Data Analysis/Assignment 1")
data <- read.csv("household_power_consumption.txt", header = T, sep=";", na.string = "?", stringsAsFactors = FALSE)

library(lubridate)
library(dplyr)

#parse dates and times with lubridate
datetime <- paste(data$Date, data$Time)
datetime_format <- parse_date_time(datetime, "dmy HMS")

#add parsed column ot original dataset
Df <- mutate(data, DT = datetime_format)

#subset using base R solution
Feb <- subset(Df, format(DT,"%d/%m/%Y") %in% c("01/02/2007","02/02/2007"))


#plot 1
hist(df$Global_active_power, main = "Global Active Power", col= "red", xlab = "Global Active Power (kilowatts)")

#copy plot to the file device, png, saved in working directory
dev.copy(png, file = "plot1.png")
dev.off()

#plot 2
with(Feb, plot(DT,Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")) #creates plots with labels; type n = plots without points
lines(Feb$DT, Feb$Global_active_power, type="l") #adds lines to plot
dev.copy(png, file = "plot2.png")
dev.off()

#plot3
png(filename="plot3.png", bg="transparent")

with(Feb, plot(DT, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", ylim = c(0,40), yaxt = "n"))

axis(side=2, at = c(0,15,30), labels = c(0,15,30))

lines(Feb$DT, Feb$Sub_metering_1, type="l")
lines(Feb$DT, Feb$Sub_metering_2, type="l", col = "red")
lines(Feb$DT, Feb$Sub_metering_3, type="l", col = "blue")

legend("topright", lty = c(1,1,1), col = c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.off()

#plot4

par(mfrow = c(2,2))

#1
with(Feb, plot(DT,Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")) 
lines(Feb$DT, Feb$Global_active_power, type="l")

#2
with(Feb, plot(DT, Voltage, xlab = "datetime", type="n"))
lines(Feb$DT, Feb$Voltage, type="l")

#3
with(Feb, plot(DT, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", ylim = c(0,40), yaxt = "n"))

axis(side=2, at = c(0,15,30), labels = c(0,15,30))

lines(Feb$DT, Feb$Sub_metering_1, type="l")
lines(Feb$DT, Feb$Sub_metering_2, type="l", col = "red")
lines(Feb$DT, Feb$Sub_metering_3, type="l", col = "blue")

legend("topright", lty = c(1,1,1), col = c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#4
with(Feb, plot(DT, Global_reactive_power, xlab = "datetime", type = "n"))
lines(Feb$DT, Feb$Global_reactive_power, type="l")

dev.copy(png, file = "plot4.png")
dev.off()
