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

# Plot 
png(filename = "plot1.png", width = 480, height = 480, bg = "white")
hist(d$Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", 
     ylim=c(0,1200))
axis(side=2, at=seq(0,1200, 200), labels=seq(0,1200,200)) 
dev.off()