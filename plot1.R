################################################################################################################################################################################################################
##
## Description:
## 
## Histogram of Global Active Power (kilowatts)
## 
##
################################################################################################################################################################################################################

#load data.table library (assuming it is already installed)
library(data.table)

# The path of the household_power_consumption.txt file. This is an example only. 
file_url <- "/Users/adrian/explore_data/household_power_consumption.txt"

# Load the household_power_consumption.txt file. Convert '?' to NA.
hpc_dt <- fread(file_url,na.strings="?")

#Convert the hpc_dt$Date column to date datatype using as.Date.
hpc_dt$Date <- as.Date(hpc_dt$Date,"%d/%m/%Y")

#Subset the datatable with the following criteria:
# hpc_dt$Date is not NA
# hpc_dt$Global_active_power is not NA
# hpc_dt$Date greater than or equal to 01 Feb 2007
# hpc_dt$Date less than or equal to 02 Feb 2007
hpc_dt <- subset(hpc_dt, is.na(hpc_dt$Global_active_power) == FALSE & is.na(hpc_dt$Date) == FALSE & hpc_dt$Date >= as.Date("01/02/2007","%d/%m/%Y") & hpc_dt$Date <= as.Date("02/02/2007","%d/%m/%Y"))

# output file to png, set background to transparent
png(filename = "plot1.png", bg="transparent")

# Set mfrow to 1,1,. This is the default but anyway just to make sure.
par(mfrow = c(1, 1))

#Plot the histogram of hpc_dt$Global_active_power
# main title: Global Active Power
# bar color: red
# x label: Global Active Power (kilowatts)
hist(as.numeric(hpc_dt$Global_active_power),main="Global Active Power", col="red",xlab="Global Active Power (kilowatts)")


#Close png device
dev.off()
