library(dplyr)
library(lubridate)

# Read the data into an initial data frame
df_power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Filter data by date
df_power1 <- filter(df_power, Date == "1/2/2007")
df_power2 <- filter(df_power, Date == "2/2/2007")
df_power <- rbind(df_power1, df_power2)

# Convert the required column to the correct unit (based on the reference charts)
df_power <- mutate(df_power, Global_active_power_kw = as.numeric(Global_active_power) / 500)

# Compute timestamp
df_power <- mutate(df_power, Timestamp = ymd_hms(paste(dmy(Date), Time, sep = " ")))

# Open graphic device
png("plot2.png", width=480, height=480)


# Plot and format the graph as required
with(df_power, plot(Timestamp, Global_active_power_kw, type = "l", ylab = "Global Active Power (kilowatts)"))


dev.off()