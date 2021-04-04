#plot4.R
# install.packages("sqldf")
library(sqldf)
 
#Read data file
file <- "household_power_consumption.txt"

#Use sqldf package to read only data where  Date = '1/2/2007' or Date = '2/2/2007'
#Specify that the separator is ";"
df <- read.csv.sql(file, "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")
df[ df == "?" ] <- NA           #replace ? by NA
df <- df [complete.cases(df), ] # Keep only the complete rows

#Create dateTime char vector by concatenating df$Date and df$Time
dateTime <- paste(df$Date, df$Time, sep=" ")

#Convert dateTime char vector to Date/Time class
dateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")


#Create plotting region with 2 rows & 2 colums
par(mfrow=c(2,2))

#Plot1
plot(dateTime, df$Global_active_power,type="l",  xlab="",ylab="Global Active Power")  

#Plot2
plot(dateTime, df$Voltage, type="l",xlab="datetime",ylab="Voltage")

#Plot3 - Call the R base plot function, plot Sub_metering_1
plot(dateTime,df$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
#Then add lines for Sub_metering_2, Sub_metering_3 
lines(dateTime, df$Sub_metering_2, type="l", col="red")
lines(dateTime, df$Sub_metering_3, type="l", col="blue")

#Add legend at top right of plot region
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)

#Plot4
plot(dateTime, df$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

#Write to png file with width=480, height=480 in pixels. 
#dev.print will copy to png and then shut the new device 
dev.print(png, "plot4.png", width=480, height=480, units = "px")

dev.off()

