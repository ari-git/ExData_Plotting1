
########################################################
#     INFORMATION OF PLATFORM CREATED AND TESTED ON    #
########################################################
# PLATFORM  : Windows 8.1, x64-Based Processor
# R Version : x64 3.1.2


####################################################
#     SOURCING, INPUT, AND OUTPUT INFORMATION      #
####################################################
# sourcing()-ing the R script will ceate the output
# INPUT:  The ".txt" data file is present in the working directory
# OUTPUT: The ".png" file will be written in the working directory


#     CLEANUP ENVIRONMENT    #
# CAUTION!! Save your environment before running the script
rm (list=ls())

#     FETCH WORKING DIRECTORY    #
workingDir = getwd()


#     READ DATA FILES     #
# ASSUMPTION: The ".txt" is present in the working directory
hPowConsume <- read.table(paste(workingDir,"./household_power_consumption.txt",sep="/"),
                          header=TRUE,sep=";",stringsAsFactors = FALSE)

# create subset data frame containing data only for "2007-02-01" and "2007-02-02"
hPowConsume$Date <- as.Date (hPowConsume$Date, format="%d/%m/%Y")
hPowConsumeSubset <- hPowConsume[(hPowConsume$Date >= as.Date("2007-02-01") & hPowConsume$Date <= as.Date ("2007-02-02")), ]

# convert variables (of the subset) to appropriate data classes
hPowConsumeSubset$Global_active_power <- as.numeric(hPowConsumeSubset$Global_active_power)
hPowConsumeSubset$Global_reactive_power <- as.numeric(hPowConsumeSubset$Global_reactive_power)
hPowConsumeSubset$Global_intensity <- as.numeric(hPowConsumeSubset$Global_intensity)
hPowConsumeSubset$Voltage <- as.numeric(hPowConsumeSubset$Voltage)
hPowConsumeSubset$Sub_metering_1 <- as.numeric(hPowConsumeSubset$Sub_metering_1)
hPowConsumeSubset$Sub_metering_2 <- as.numeric(hPowConsumeSubset$Sub_metering_2)
hPowConsumeSubset$Sub_metering_3 <- as.numeric(hPowConsumeSubset$Sub_metering_3)

# create the DateTime variable by combining the Date and Time variables
hPowConsumeSubset$DateTime <- paste (hPowConsumeSubset$Date, hPowConsumeSubset$Time, sep=" ")
hPowConsumeSubset$DateTime <- strptime (hPowConsumeSubset$DateTime, format = "%Y-%m-%d %T")


#     PLOT 3     #
# open the png bitmap device with the specified width
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# create plot (will be written to the png device)
par (mfrow=c(1,1))
with (hPowConsumeSubset, plot (DateTime, Sub_metering_1, ylab="Energy sub metering", xlab="", col="black", type="s"))
with (hPowConsumeSubset, lines (DateTime, Sub_metering_2, col="red"))
with (hPowConsumeSubset, lines (DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1), cex=0.9, col = c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close device
dev.off()

#     CLEANUP ENVIRONMENT    #
rm (list=ls())
