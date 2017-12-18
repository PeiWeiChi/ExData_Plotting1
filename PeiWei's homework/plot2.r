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


# plot 2
png("plot2.png", width=480, height=480)

plot(x = subEPC[, DateTime]
     , y = subEPC[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()