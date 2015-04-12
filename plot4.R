library(dplyr)
library(lubridate)

# Read the data into an initial data frame
df_power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Filter data by date
df_power1 <- filter(df_power, Date == "1/2/2007")
df_power2 <- filter(df_power, Date == "2/2/2007")
df_power <- rbind(df_power1, df_power2)

# Convert the required columns to the correct unit (based on the reference charts)
df_power <- mutate(df_power, Global_active_power_kw = as.numeric(Global_active_power) / 500)
df_power <- mutate(df_power, Global_reactive_power_kw = as.numeric(Global_reactive_power) / 500)


# Compute timestamp
df_power <- mutate(df_power, Timestamp = ymd_hms(paste(dmy(Date), Time, sep = " ")))

# Open graphic device
png("plot4.png", width=480, height=480)



# Plot and format the graph as required
par("mar" = c(2,2,2,2))
par("mfrow" = c(2,2))

with(df_power, plot(Timestamp, Global_active_power_kw, type = "l", ylab = "Global Active Power (kilowatts)"))

with(df_power, plot(Timestamp, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))

with(df_power, plot(Timestamp, Sub_metering_1, type = "l", xlab = " ", ylab = "Energy sub metering"))
lines(df_power$Timestamp, df_power$Sub_metering_2, type = "l", col = "red")
lines(df_power$Timestamp, df_power$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub-metering 1", "Sub-metering 2", "Sub-metering 3"), lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)

with(df_power, plot(Timestamp, Global_reactive_power_kw, type = "l", ylab = "Global Reactive Power (kilowatts)", xlab = "datetime"))

dev.off()

