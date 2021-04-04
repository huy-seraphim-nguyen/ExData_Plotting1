#plot1.R
# install.packages("sqldf")
library(sqldf)

#Read data file
file <- "household_power_consumption.txt"

#Use sqldf package to read only data where  Date = '1/2/2007' or Date = '2/2/2007'
#Specify that the separator is ";"
df <- read.csv.sql(file, "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")
df[ df == "?" ] <- NA           #replace ? by NA
df <- df [complete.cases(df), ] # Keep only the complete rows

#Check the structure of df (data frame)
str(df)

#Call the R base plot function, and write to png file with width=480, height=480 in pixels
hist(df$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.print(png, "plot1.png", width=480, height=480, units = "px")

#Close device
dev.off()
