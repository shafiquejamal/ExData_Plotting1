# Read in only the data that will be used: rows corresponding to dates from 2007-02-01 to 2007-02-02 inclusive

# Source of the following lines: https://stackoverflow.com/questions/6592219/read-csv-from-specific-row
library(sqldf)
power_consumption <- read.csv.sql(file = 'household_power_consumption.txt', 
                                  sql = "SELECT * FROM file WHERE Date = '1/2/2007' or Date = '2/2/2007'", 
                                  sep = ";", 
                                  header = T)

power_consumption$DateTime <- strptime(paste(power_consumption$Date, 
                                             power_consumption$Time), 
                                       '%d/%m/%Y %H:%M:%OS') 

png(filename = 'plot4.png', width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(power_consumption$DateTime, power_consumption$Global_active_power, type = 'l', xlab ='', 
     ylab = 'Global Active Power (kilowatts)')

plot(power_consumption$DateTime, power_consumption$Voltage, type = 'l', xlab ='datetime', 
     ylab = 'Voltage')

plot(power_consumption$DateTime, power_consumption$Sub_metering_1, type = 'l', xlab ='', 
     ylab = 'Energy sub metering')
lines(power_consumption$DateTime, power_consumption$Sub_metering_2, type = 'l', col = 'red')
lines(power_consumption$DateTime, power_consumption$Sub_metering_3, type = 'l', col = 'blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1,1), bty = 'n', xjust = 1)

plot(power_consumption$DateTime, power_consumption$Global_reactive_power, type = 'l', 
     xlab ='datetime', ylab = 'Global_reactive_power')

dev.off()
