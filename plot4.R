# Project 4 -  by Rafael Espericueta
#
# plot4.R  -  Code to generate plot4.png
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
dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power))
dat$Global_reactive_power <- as.numeric(as.character(dat$Global_reactive_power))
dat$Voltage <- as.numeric(as.character(dat$Voltage))
dat$Sub_metering_1 <- as.numeric(as.character(dat$Sub_metering_1))
dat$Sub_metering_2 <- as.numeric(as.character(dat$Sub_metering_2))
dat$Sub_metering_3 <- as.numeric(as.character(dat$Sub_metering_3))

# Transform Global_active_power values to yield correct "y" values in plot.
dat$Global_active_power <- dat$Global_active_power

# Transform Voltage values to yield correct "y" values in plot.
#dat$Voltage <- 0.01 * dat$Voltage + 227.

# Transform Global_reactive_power values to yield correct "y" values in plot.
theMax <- max(dat$Global_reactive_power)
dat$Global_reactive_power <- 0.5 * dat$Global_reactive_power / theMax

# We need a new DateTime column, that combines the data and the time.
dat$Date <- as.Date(as.character(dat$Date), format="%d/%m/%Y")
dat$Time <- as.character(dat$Time)
dat$DateTime <- paste(dat$Date, dat$Time)
dat$DateTime <- strptime(dat$DateTime, format="%Y-%m-%d %H:%M:%S")

# Create the plot.
#
attach(dat)  # makes the elements in data frame dat accessible without specifying "dat$".
par(mfcol=c(2,2))

shrink_factor <- 0.7  # to shrink plot text

# Upper left.
plot(DateTime, Global_active_power,
     type="l", 
     xlab="",
     cex.axis = shrink_factor,
     cex.lab = shrink_factor,
     cex = shrink_factor,
     ylab='Global Active Power')

# Lower left.
plot(DateTime, Sub_metering_1, type="l", 
     xlab="",
     cex.axis = shrink_factor,
     cex.lab = shrink_factor,
     cex = shrink_factor,
     ylim = c(-0.01, max(Sub_metering_1)),
     yaxp  = c(0, 30, 3),
     ylab = 'Energy sub metering')
lines(DateTime, Sub_metering_2, type="l", col="red")
lines(DateTime, Sub_metering_3, type="l", col="blue")
legend("topright", 
       inset = 0.015,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       bty = "n", 
       cex = shrink_factor,
       col = c("black", "blue", "red"))  

# Upper right.
plot(DateTime, Voltage,
     type = "l", 
     xlab = "datetime",
     cex.axis = shrink_factor,
     cex.lab = shrink_factor,
     cex = shrink_factor,
     ylab = 'Voltage')

# Lower right.
plot(DateTime, Global_reactive_power,
     type = "l", 
     cex.axis = shrink_factor,
     cex.lab = shrink_factor,
     cex = shrink_factor,
     ylim = c(-0.01, 0.51),
     yaxp = c(0, 0.5, 5),
     xlab = "datetime")

# Save the plot to a file.
dev.copy(png,'./figure/plot4.png');  dev.off()



