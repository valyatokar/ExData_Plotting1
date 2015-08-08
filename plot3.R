## downloading and unzipping data file:
temp<-tempfile()
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,temp,method="curl")

## reading data into R:
data_classes<-c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
mydata<-read.table(unz(temp,"household_power_consumption.txt"), sep=";", header=TRUE, 
                   colClasses=data_classes, na.strings="?")
unlink(temp)

## subsetting data and creating a new set for requested dates only - "shortdata":
subset1<-mydata[which(mydata$Date=="1/2/2007"),]
subset2<-mydata[which(mydata$Date=="2/2/2007"),]
shortdata<-merge(subset1, subset2,all=TRUE,sort=FALSE)

## formatting date and time:
shortdata$Date<-as.Date(shortdata$Date,format="%d/%m/%Y")
date_time<-paste(shortdata$Date,shortdata$Time)
shortdata$newDate<-strptime(date_time, "%Y-%m-%d %H:%M:%S")

## creating plot 3:
png("plot3.png", width = 480, height = 480)
par(mar=c(2,4,4,2))
plot(shortdata$newDate,shortdata$Sub_metering_1, ylab="Energy sub metering", type="n")
lines(shortdata$newDate,shortdata$Sub_metering_1)
lines(shortdata$newDate,shortdata$Sub_metering_2, col="red")
lines(shortdata$newDate,shortdata$Sub_metering_3, col="blue")
legend('topright', legend=names(shortdata)[7:9], lty=1, col=c("black","red","blue"))
dev.off()