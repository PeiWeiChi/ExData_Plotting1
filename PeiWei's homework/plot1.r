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

# plo1

png("plot1.png", width=480, height=480)

hist(subEPC$Global_active_power, col= "red", main = "Gloabal Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency")

dev.off()