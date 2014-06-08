# Project 1  -  by Rafael Espericueta
#
# plot2.R  -  Code to generate plot2.png
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

# Change this column from factor to numeric.  
# NOTE:  This didn't work without casting this factor column as character first.
dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power))

# We need a new DateTime column, that combines the data and the time.
dat$Date <- as.Date(as.character(dat$Date), format="%d/%m/%Y")
dat$Time <- as.character(dat$Time)
dat$DateTime <- paste(dat$Date, dat$Time)
dat$DateTime <- strptime(dat$DateTime, format="%Y-%m-%d %H:%M:%S")

# Create the plot.
plot(dat$DateTime, dat$Global_active_power, 
     type = "l", 
     xlab = "",
     cex.axis = 0.8,
     cex.lab = 0.8,
     ylab='Global Active Power (kilowatts)')

# Save the plot to a file.
dev.copy(png,'./figure/plot2.png');   dev.off()
