# Coursera - Exploratory Data Analysis -  Rafael Espericueta

# Project 1 
#
# plot1.R  -  Code to generate plot1.png
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
dat$Global_active_power <- as.numeric(as.character(dat$Global_active_power))

# Create the histogram.
hist(dat$Global_active_power, 
     main = "Global Active Power", 
     col = 'red',
     xlab = 'Global Active Power (kilowatts)',
     cex.axis = 0.8,
     cex.lab = 0.8,
     cex.main = 0.9,
     ylab = 'Frequency')

# Save the plot to a file.
dev.copy(png,'./figure/plot1.png');   dev.off()
