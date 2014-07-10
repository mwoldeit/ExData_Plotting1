##for English weekdays
Sys.setlocale('LC_TIME','C')

##this time use data.table :)
library(data.table)
#object.size(double(length = 9* 2075259))#149418688 bytes,roughly 150MB

##only read the Date variable
years<-data.frame(fread("household_power_consumption.txt", header = T, sep = ";",colClasses = c('Date', rep("NULL",8)), nrows = 2075259))
useDate<-which(years$Date %in% c("1/2/2007" , "2/2/2007"), arr.ind = T)
is.unsorted(useDate) #FALSE, therefore we have continuing indexes

##read the data
data<-data.frame(fread("household_power_consumption.txt", header = F, 
sep = ";", colClasses = c(rep("character",2 ), rep("numeric", 7)),
skip = min(useDate) , nrows = length(useDate), na.strings = "?")) 

##read header and typecast variables
names(data)<-read.table("household_power_consumption.txt", nrows = 1,colClasses = "character", sep = ";")

##make datetime variable
datetime<-paste(data$Date, data$Time)
datetime<-strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
data<-cbind(datetime,data[,c(-1,-2)])

##make png plot 2
png('plot2.png')
plot(data$datetime, data$Global_active_power, type='l',
ylab = 'Global active power (kilowatts)', xlab = '')
dev.off()

