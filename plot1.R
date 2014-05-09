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

#create  plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(pdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()