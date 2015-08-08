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

## creating plot 1:
png("plot1.png", width = 480, height = 480)
hist(shortdata$Global_active_power, col="red", breaks=12, 
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()