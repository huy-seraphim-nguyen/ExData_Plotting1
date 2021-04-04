
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

#Call the R base plot function, and write to png file with width=480, height=480 in pixels
png("plot2.png", width=480, height=480, units = "px")
plot(dateTime, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Close device
dev.off() 

