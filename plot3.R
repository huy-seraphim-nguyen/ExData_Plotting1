
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

#Call the R base plot function, plot Sub_metering_1
plot(dateTime, df$Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy Sub Metering")

#Then add lines for Sub_metering_2, Sub_metering_3 
lines(dateTime, df$Sub_metering_2, type="l", col="red")
lines(dateTime, df$Sub_metering_3, type="l", col="blue")

#Add legend at top right of plot region
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#Write to png file with width=480, height=480 in pixels. 
#dev.print will copy to png and then shut the new device  
dev.print(png, "plot3.png", width=480, height=480, units = "px")

dev.off()
 

