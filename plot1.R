#Please see "loaddata.R", I use this file with all 4 plots
source("loaddata.R")
#Getting data
subset<-prepareData()

#First graph is a simple histogram

#First, open the png graphic device
png("plot1.png", width = 480, height = 480)

#Then plot histogram
title<-"Global Active Power"
x_lab<-"Global Active Power (kilowatts)"

hist(subset$Global_active_power, main = title, col = "red", xlab = x_lab)

#Close dev
dev.off()