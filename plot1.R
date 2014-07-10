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


##plot no 1 on png device
png(file ='./plot1.png', width =480, height = 480, units = 'px')
hist(data$Global_active_power, col ='red', xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')
dev.off()
