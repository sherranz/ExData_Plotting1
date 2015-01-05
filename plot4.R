#Please see "loaddata.R", I use this file with all 4 plots
source("loaddata.R")
#Getting data
subset<-prepareData()

#Fourth graph is a composition of plots 2, 3 and two new plots

#First, open the png graphic device
png("plot4.png", width = 480, height = 480)

# I want a 2x2 plot panel
par(mfcol = c(2, 2))

#First Plot is plot2.R

y_lab<-"Global Active Power (kilowatts)"
plot(subset$datetime, subset$Global_active_power, type = "l", ylab=y_lab, xlab="")

#Second plot is plot3.R
y_lab<-"Energy sub metering"
plot(subset$datetime, subset$Sub_metering_1, type = "l", ylab = y_lab, xlab="")
lines(subset$datetime, subset$Sub_metering_2, type = "l", col="red")
lines(subset$datetime, subset$Sub_metering_3, type = "l", col="blue")
cols<-c("black", "red", "blue")
legnd<-c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", col=cols, legend = legnd, lty=c(1,1), bty = "n")

#Third plot is a new plot
with(subset, plot(datetime, Voltage, type = "l"))

#Fourth plot is a new plot
with(subset, plot(datetime, Global_reactive_power, type = "l"))

#Close dev
dev.off()