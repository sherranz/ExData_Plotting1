#Please see "loaddata.R", I use this file with all 4 plots
source("loaddata.R")
#Getting data
subset<-prepareData()

#Third graph is a union of lines

#First, open the png graphic device
png("plot3.png", width = 480, height = 480)

#Then plot...

y_lab<-"Energy sub metering"

plot(subset$datetime, subset$Sub_metering_1, type = "l", ylab = y_lab, xlab="")

#Adding lines
lines(subset$datetime, subset$Sub_metering_2, type = "l", col="red")
lines(subset$datetime, subset$Sub_metering_3, type = "l", col="blue")

#Adding legend
cols<-c("black", "red", "blue")
legnd<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

legend("topright", col=cols, legend = legnd, lty=c(1,1))

#And close dev
dev.off()
