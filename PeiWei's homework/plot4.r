library(lubridate)
library(data.table)

# Load the designed data
EPC <- data.table::fread('household_power_consumption.txt',
                         header = T,
                         sep = ";"
)
# Modify the time format
EPC[,DateTime := as.POSIXct(paste(Date, Time),format = "%d/%m/%Y %H:%M:%S")]
EPC$Date = dmy(EPC$Date)
# Filter data by date
subEPC <- subset(EPC,Date == ("2007-02-01" )|Date ==("2007-02-02" ))
subEPC[,3:9] <- subEPC[,lapply(.SD,as.numeric),.SDcols=3:9]

# plot4

par(mfrow=c(2,2))
png("plot4.png", width=480, height=480)

plot(subEPC[, DateTime], subEPC[, Global_active_power], 
     type="l", xlab="", ylab="Global Active Power")
plot(subEPC[, DateTime],subEPC[, Voltage], type="l",
     xlab="datetime", ylab="Voltage")
plot(x = subEPC[, DateTime]
     , y = subEPC[, Sub_metering_1]
     , type="l", xlab="", ylab="Energy sub metering")

lines(x = subEPC[, DateTime]
      , y = subEPC[, Sub_metering_2],col='Red')

lines(x = subEPC[, DateTime]
      , y = subEPC[, Sub_metering_3],col='Blue')

legend("topright", col=c("black", "red", "blue"),
       lty=1, lwd=c(1,1), bty="n", cex=0.5,y.intersp=0.1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(subEPC[, DateTime], subEPC[,Global_reactive_power], 
     type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off() 