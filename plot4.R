################################################################################################################################################################################################################
##
## Description:
## 
## 4 Plots: Global_active_power, Voltage, Sub_metering, Global_reactive_power over two-day period (01/02/2007 - 02/02/2007).
## 
##
################################################################################################################################################################################################################

#load data.table library (assuming it is already installed)
library(data.table)

# The path of the household_power_consumption.txt file. This is an example only. 
file_url <- "/Users/adrian/explore_data/household_power_consumption.txt"


# Load the household_power_consumption.txt file. Convert '?' to NA.
hpc_dt <- fread(file_url,na.strings="?")

#Convert the hpc_dt$Date column to date and assign to a temporary column. This will be used for subsetting 
# The hpc_dt$Date was retained as string. It will be combined with hpc_dt$Time and used for creating a datetime column via strptime()
hpc_dt$DateTmp <- as.Date(hpc_dt$Date,"%d/%m/%Y")

#Subset the datatable with the following criteria:
# hpc_dt$Date is not NA
# hpc_dt$Time is not NA
# hpc_dt$Global_active_power is not NA
# hpc_dt$DateTmp greater than or equal to 01 Feb 2007
# hpc_dt$DateTmp less than or equal to 02 Feb 2007
hpc_dt <- subset(hpc_dt, is.na(hpc_dt$Global_active_power) == FALSE & is.na(hpc_dt$Date) == FALSE & hpc_dt$DateTmp >= as.Date("01/02/2007","%d/%m/%Y") & hpc_dt$DateTmp <= as.Date("02/02/2007","%d/%m/%Y"))

#Combine date and time columns using strptime and as.POSIXct.
hpc_dt[, datetime:=as.POSIXct(strptime(paste(hpc_dt$Date,hpc_dt$Time,sep=" "), format = "%d/%m/%Y %H:%M:%S"))]

# Set mfrow to (2,2).
par(mfrow = c(2, 2))

# 1st plot
# Plot the hpc_dt$Global_active_power over two-day period (01/02/2007 - 02/02/2007)
# type = "l" line
# y label = Global Active Power (kilowatts)
# bg = "transparent"
# cex.lab=0.75,cex.axis=0.8  (adjust label and axis font size to match the sample png file)
plot(hpc_dt$datetime,as.numeric(hpc_dt$Global_active_power),type="l",xlab="",ylab="Global Active Power (kilowatts)", bg = "transparent", cex.lab=0.75,cex.axis=0.8)

# 2nd Plot
# Plot the hpc_dt$Voltage over two-day period (01/02/2007 - 02/02/2007)
# x label: datetime
# y label: Voltage
# bg = "transparent"
# cex.lab=0.75,cex.axis=0.8  (adjust label and axis font size to match the sample png file)
plot(hpc_dt$datetime,as.numeric(hpc_dt$Voltage),type="l",xlab="datetime",ylab="Voltage", bg = "transparent", cex.lab=0.75,cex.axis=0.8)


# 3rd PLot
# Plot the hpc_dt$Sub_metering1 over two-day period (01/02/2007 - 02/02/2007)
# type = "l" line
# col= "black"
# y label: Energy sub metering
# bg = "transparent"
# cex.lab=0.75,cex.axis=0.8  (adjust label and axis font size to match the sample png file)
plot(hpc_dt$datetime,as.numeric(hpc_dt$Sub_metering_1),type="l", col="black", xlab="",ylab="Energy sub metering", bg = "transparent", cex.lab=0.75,cex.axis=0.8)

#Add Sub_metering_2
lines(hpc_dt$datetime,hpc_dt$Sub_metering_2,col="red")

#Add Sub_metering_3
lines(hpc_dt$datetime,hpc_dt$Sub_metering_3,col="blue")

#Add legend
legend("topright", bty = "n", lwd = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),cex=0.8,yjust=0.5)


# 4th PLot
# Plot the hpc_dt$Global_reactive_power over two-day period (01/02/2007 - 02/02/2007)
# x label: datetime
# y label: Global_reactive_power
# bg = "transparent"
# cex.lab=0.75,cex.axis=0.8  (adjust label and axis font size to match the sample png file)
plot(hpc_dt$datetime,as.numeric(hpc_dt$Global_reactive_power),type="l",xlab="datetime",ylab="Global_reactive_power", bg = "transparent", cex.lab=0.75,cex.axis=0.8)



#Copy plot to png file
dev.copy(png, file = "plot4.png")

#Close png device
dev.off()
