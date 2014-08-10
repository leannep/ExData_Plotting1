# Plot Global active power as a function of time
# and save  to a PNG file with a 
# width of 480 pixels and a height of 480 pixels.
#' Load the data into a table
#' @return d the data table
loadData <- function() {
  
  # The data file 
  f<- 'household_power_consumption.txt'
  
  # Load a subset of the data 
  q <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  d<- read.csv.sql(f, sql=q, header=TRUE,
                   stringsAsFactors=FALSE, sep=";")
  
  # Replace the '?' na
  d[d=='?']=NA
  
  # Convert date from character to Date format
  d$Time <- as.POSIXct(strptime(paste(d$Date, d$Time), "%d/%m/%Y %H:%M:%S"))
  d$Date <- as.Date(d$Date, "%d/%m/%Y")
  d
}

# Read in the data
d<-loadData()

# Divide the page and plot
png(filename = "plot4.png", width = 480, height = 480, bg = "white")
par(mfrow=c(2,2), mar=c(3,3,3,1), mgp=c(2,1,0))

#Plot1
plot(d$Time, d$Global_active_power, 
     ylab="Global Active Power (kilowatts)", 
     xlab="",
     type='l')

# Plot 2
plot(d$Time, d$Voltage, 
     ylab="Voltage", 
     xlab="datetime",
     type='l')

#Plot 3
plot(d$Time, d$Sub_metering_1, 
     ylab="Energy sub metering", 
     xlab="",
     type='l', col="black")
lines(d$Time, d$Sub_metering_2, col="red")
lines(d$Time, d$Sub_metering_3, col="blue")
legend("topright", box.col = "white",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)

# Plot 4
plot(d$Time, d$Global_reactive_power, 
     ylab="Global_reactive_power", 
     xlab="datetime",
     type='l')

dev.off()