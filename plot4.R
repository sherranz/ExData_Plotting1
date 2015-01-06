# Size estimation:
# Documentation says data is 2,075,259 rows and 9 cols. 
# First two columns are strings, by 10 and 8 chars
# 18 * 2,075,259 = 37,354,662 bytes
# The other seven cols are numbers, 4 bytes each, then 7 * 4 = 28 and
# 28 * 2,075,259 = 58,107,252 bytes
# About 100 Mb, thats fine
# Later, data size is about 133MB, because
# 1. First two columns are stored as factors, with size mean close to 4 bytes
# 2. Last seven columns takes 8 bytes per row. I don't know why, do you?
# Then a row is 4 * 2 + 7 * 8 = 64 bytes (a bit more)
# 64 * 2,075,259 = 132,816,576, so much closer

#First of all, I change locale, you know, I'm spanish and Thursday = jueves :)
if (.Platform$OS.type == "windows"){
  Sys.setlocale("LC_TIME", 'English')
} else {
  Sys.setlocale("LC_TIME", 'en_GB.UTF-8')
}

#I'll use lubridate
library(lubridate)

loadData<-function(rows = Inf){
  localfile<-"exdata-data-household_power_consumption.zip"
  if (!file.exists(localfile)){
    file = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = file, destfile = localfile , method = "curl")
  }
  
  unzippeddata<-"household_power_consumption.txt"
  if(!file.exists(unzippeddata)){
    unzip(localfile)
  }
  
  data<-read.table(unzippeddata, sep = ";", header = T, nrows = rows, na.strings = "?")
  data
}

prepareData<-function(){
  
  #Loading data
  data<-loadData()
  #And subsetting
  subset<-data[(data$Date == '1/2/2007') | (data$Date == '2/2/2007'),]
  
  #I'll create a new column for time
  subset$datetime<-dmy_hms(paste(subset$Date, subset$Time, sep = " "))
  
  #Return subset
  subset
}

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