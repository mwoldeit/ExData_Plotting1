##for English weekdays
Sys.setlocale('LC_TIME','C')

##read data with sqldf package
library(sqldf)
data <- read.csv.sql("household_power_consumption.txt", sep = ';',
	header =T, 
        sql = "SELECT * FROM file WHERE Date='1/2/2007' OR 
	Date='2/2/2007'")

##make datetime variable
datetime<-paste(data$Date, data$Time)
datetime<-strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
data<-cbind(datetime,data[,c(-1,-2)])


##make png of plot3
png('plot3.png')
plot(data$datetime, data$Sub_metering_1, type = 'l', 
ylab = 'Energy sub metering', xlab = '')
lines(data$datetime, data$Sub_metering_2, col = 'red')
lines(data$datetime, data$Sub_metering_3, col = 'blue')
legend('topright', legend = paste('Sub_metering', 1:3, sep = '_'),lty = 1, col = c('black', 'red', 'blue')) 
dev.off()
