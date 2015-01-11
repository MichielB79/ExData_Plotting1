##### Download and unzip the data in directory 'data' #####

if(!file.exists("data")) {
  dir.create("data")
}

if(!file.exists("data/household_power_consumption.txt")) {
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file_url, destfile="./data/data.zip")
  date.downloaded <- date()
  unzip("./data/data.zip", exdir="data")
}


##### Read the data into R and make a subset #####

data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
data <- data[which(data$Date=="2/2/2007" | data$Date=="1/2/2007"),]


##### Create Date & Time column #####

data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")


##### Create plot 3 #####

Sys.setlocale("LC_TIME", "English")
plot(data$DateTime, data$Sub_metering_1, 
     type="l", 
     col="black", 
     xlab=NA, 
     ylab="Energy sub metering")
  lines(data$DateTime, data$Sub_metering_2, 
      type="l", 
      col="red")
  lines(data$DateTime, data$Sub_metering_3, 
      type="l", 
      col="blue")
  legend("topright", 
       lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex=0.95)


##### Save plot 3 as png with width 480 and heigt 480 #####

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()