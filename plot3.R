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

# Part 5: Create plot 3
Sys.setlocale("LC_TIME", "English")
par(mar=c(5, 5, 4, 5) + 0.1)
plot(subdata$DateTime, subdata$Sub_metering_1, type="l", col="black", xlab=NA, ylab="Energy sub metering")
lines(subdata$DateTime, subdata$Sub_metering_2, type="l", col="red")
lines(subdata$DateTime, subdata$Sub_metering_3, type="l", col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.95)

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()