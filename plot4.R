###################################################
#  prior to running this script: 
#  data file "household_power_consumption.txt" must be 
#  extracted from zip archive 
#  and placed in working directory 
##################################################

#function to convert text string to Date, for use in read.table
setClass("myDateCol")   
setAs("character","myDateCol", function(from) as.Date(from, format="%d/%m/%Y"))

#read data and check structure 
data <-  read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("myDateCol", "character", rep("numeric", 7)), as.is = TRUE)
str(data)

#subset data for 2007-02-01 and 2007-02-02
plotdays <- as.Date(c("2007-02-01", "2007-02-02"), format="%Y-%m-%d")
pdata <- data[data$Date %in% plotdays, ]
#verifty that number of data rows equates to 2 days * 24 hours * 60 minutes =  2880
length(pdata$Date)
#add date-time variable
pdata$dtime <- strptime(paste(strftime(pdata$Date), pdata$Time, sep = " "), "%Y-%m-%d %H:%M:%S")

#create  plot 4
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 11, type = "windows")
par(mfrow = c(2,2))

plot(pdata$dtime, pdata$Global_active_power, main = "", type = "l", ylab = "Global Active Power", xlab = "")

plot(pdata$dtime, pdata$Voltage, main = "", type = "l", ylab = "Voltage", xlab = "datetime")

plot(pdata$dtime, pdata$Sub_metering_1, main = "", type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(pdata$dtime, pdata$Sub_metering_2, col = "red")
lines(pdata$dtime, pdata$Sub_metering_3, col = "blue")
legend("topright", names(pdata)[7:9], lty = 1, col = c("black", "red", "blue"), bty = "n")

plot(pdata$dtime, pdata$Global_reactive_power, main = "", type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

