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

# Part 5: Create plot 2
Sys.setlocale("LC_TIME", "English")
plot(subdata$DateTime, subdata$Global_active_power, type="l", xlab=NA, ylab="Global Active Power (kilowatts)")

# Part 6: Create png file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()