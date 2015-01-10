# Part 1: Create a directory 'data' in the working directory, if it doesn't exist, and download & unzip the data
if(!file.exists("data")) {
  message("Directory 'data' created")
  dir.create("data")
}

if(!file.exists("data/household_power_consumption.txt")) {
  message("Download data")
  
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file_url, destfile="./data/data.zip")
  date.downloaded <- date()
  list.files("./data")
  unzip("./data/data.zip", exdir="data")
}

# Part 2: Read table
data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# Part 3: Subset rows and remove data
subdata <- data[which(data$Date=="2/2/2007" | data$Date=="1/2/2007"),]
row.names(subdata)<-NULL
rm("data")

# Part 4: Create Date & Time column
subdata$DateTime <- paste(subdata$Date, subdata$Time)
subdata$DateTime <- strptime(subdata$DateTime, format = "%d/%m/%Y %H:%M:%S")
str(subdata)

# Part 5: Create plot 3
Sys.setlocale("LC_TIME", "English")
par(mfrow=c(2,2))
  # Plot 1
  plot(subdata$DateTime, subdata$Global_active_power, type="n", xlab=NA, ylab="Global Active Power (kilowatts)")
  lines(subdata$DateTime, subdata$Global_active_power, type="l")
  # Plot 2
  plot(subdata$DateTime, subdata$Voltage, type="n", xlab="datetime", ylab="Voltage")
  lines(subdata$DateTime, subdata$Voltage, type="l")
  #Plot 3
  plot(subdata$DateTime, subdata$Sub_metering_1, type="l", col="black", xlab=NA, ylab="Energy sub metering")
  lines(subdata$DateTime, subdata$Sub_metering_2, type="l", col="red")
  lines(subdata$DateTime, subdata$Sub_metering_3, type="l", col="blue")
  legend("topright", lty = 1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.95)
  #Plot 4
  plot(subdata$DateTime, subdata$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")
  lines(subdata$DateTime, subdata$Global_reactive_power, type="l")

# Part 6: Create png file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()