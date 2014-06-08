# Project 1  -  by Rafael Espericueta
#
# plot3.R  -  Code to generate plot3.png
#
# Dataset: Electric power consumption (UCI)

# Download and read the power consumption data.
fileName <- "household_power_consumption.txt"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()   
download.file(fileUrl, temp, method="curl")  # a little extra work to unzip the file...
dat <- read.csv(unz(temp, fileName), sep=';', header=TRUE)
unlink(temp)
dateHousingDownloaded <- date()

# Only keep the two days data that we need.
dat <- subset(dat, Date=="1/2/2007" | Date=="2/2/2007")

# Change columns from factor to numeric.  
#dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power))
#dat$Global_reactive_power <- as.numeric(as.character(dat$Global_reactive_power))
#dat$Sub_Voltage <- as.numeric(as.character(dat$Voltage))
dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))
dat$Sub_metering_3 <- as.numeric(as.character(dat$Sub_metering_3))

# We need a new DateTime column, that combines the data and the time.
dat$Date <- as.Date(as.character(dat$Date), format="%d/%m/%Y")
dat$Time <- as.character(dat$Time)
dat$DateTime <- paste(dat$Date, dat$Time)
dat$DateTime <- strptime(dat$DateTime, format="%Y-%m-%d %H:%M:%S")

# Make the plot.
attach(dat)  # makes the elements in data frame dat accessible without specifying "dat$".
plot(DateTime, Sub_metering_1, type="l", 
     xlab="",
     ylim = c(-0.01, max(Sub_metering_1)),
     yaxp  = c(0, 30, 3),
     cex.axis = 0.8,
     cex.lab = 0.8,
     ylab='Energy sub metering')
lines(DateTime, Sub_metering_2, type="l", col="red")
lines(DateTime, Sub_metering_3, type="l", col="blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       cex = 0.8, 
       col = c("black", "blue", "red"))  

# Save the plot to a file.
dev.copy(png,'./figure/plot3.png');   dev.off()
