
getwd()
setwd(your path)
rm(list=ls())

###downalod data.

if(!file.exists("data")) {
        dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/household_power_consumption.zip", method="curl")
list.files("./data")

###unzip the content

zipF<- "./data/household_power_consumption.zip"
outDir<-"./data"
unzip(zipF,exdir=outDir)

###see the files from the folder
list.files("./data")

###read 100 cases to see the file and classes for variables
sampledata <- read.table("./data/household_power_consumption.txt",header=TRUE, sep=";", nrows = 100,na.strings="?")
str(sampledata)
View(sampledata)


###calculate memory required; I think it is ok for my system

memory<-2075259*9*8
memorymb<-memory/2^{20}
memorymb

###read the entire database
data<-read.table("./data/household_power_consumption.txt",header=TRUE, sep=";",na.strings="?")
str(data)



###subset data
validdata<-subset(data, Date=="1/2/2007"|Date=="2/2/2007")
str(validdata)

###change "Date" variable to date format and merge with time
validdata$Date<-as.Date(validdata$Date, format = "%d/%m/%Y")
class(validdata$Date)
datetime <- paste(as.Date(validdata$Date), validdata$Time)
View(datetime)
validdata$DateTime <- as.POSIXct(datetime)
class(validdata$DateTime)


###PLOT4.
par(mfrow=c(2,2))
with(validdata, plot(DateTime,Global_active_power,type = "l",xlab=" ", ylab = "Global Active Power"))
with(validdata, plot(DateTime,Voltage,type = "l",xlab="datetime", ylab = "Voltage"))

with(validdata, plot(DateTime,Sub_metering_1,type = "l",xlab=" ", ylab = "Energy sub metering"))
points(validdata$DateTime,validdata$Sub_metering_2,type = "l", col="red")
points(validdata$DateTime,validdata$Sub_metering_3,type = "l", col="blue")

legend("topright",lty = 1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(validdata, plot(DateTime,Global_reactive_power,type = "l",xlab="datetime", ylab = "Global_reactive_power"))


###copy the chart to png

dev.copy(png,file="plot4.png",width=480, height=480)
dev.off()

par(mfrow=c(1,1))



