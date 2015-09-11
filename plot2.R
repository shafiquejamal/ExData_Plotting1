# Read in only the data that will be used: rows corresponding to dates from 2007-02-01 to 2007-02-02 inclusive

# Source of the following lines: https://stackoverflow.com/questions/6592219/read-csv-from-specific-row
library(sqldf)
power_consumption <- read.csv.sql(file = 'household_power_consumption.txt', sql = "SELECT * FROM file WHERE Date = '1/2/2007' or Date = '2/2/2007'", sep = ";", header = T)

power_consumption$DateTime <- strptime(paste(power_consumption$Date, power_consumption$Time), '%d/%m/%Y %H:%M:%OS') 

png(filename = 'plot2.png', width = 480, height = 480, units = "px")
plot(power_consumption$DateTime, power_consumption$Global_active_power, type = 'l', xlab ='', ylab = 'Global Active Power (kilowatts)')
dev.off()
