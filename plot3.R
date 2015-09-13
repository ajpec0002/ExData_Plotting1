################################################################################################################################################################################################################
##
## Description:
## 
## Plot Sub_metering over two-day period (01/02/2007 - 02/02/2007).
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

# output file to png, set background to transparent
png(filename = "plot3.png", bg="transparent")

# Set mfrow to 1,1,. This is the default but anyway just to make sure.
par(mfrow = c(1, 1))

#Plot the hpc_dt$Sub_metering1 over two-day period (01/02/2007 - 02/02/2007)
# y label: Energy sub metering
plot(hpc_dt$datetime,as.numeric(hpc_dt$Sub_metering_1),type="l", col="black", xlab="",ylab="Energy sub metering")

#Add Sub_metering_2
lines(hpc_dt$datetime,hpc_dt$Sub_metering_2,col="red")

#Add Sub_metering_3
lines(hpc_dt$datetime,hpc_dt$Sub_metering_3,col="blue")

#Add legend
legend("topright", lwd = 1,  col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#Close png device
dev.off()
