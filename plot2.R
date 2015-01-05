#Please see "loaddata.R", I use this file with all 4 plots
source("loaddata.R")
#Getting data
subset<-prepareData()

#Second graph is a simple plot

#First, open the png graphic device
png("plot2.png", width = 480, height = 480)

#Then plot...

y_lab<-"Global Active Power (kilowatts)"

plot(subset$datetime, subset$Global_active_power, type = "l", ylab=y_lab, xlab="")

#And close dev
dev.off()
