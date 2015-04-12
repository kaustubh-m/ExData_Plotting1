library(dplyr)

# Read the data into an initial data frame
df_power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Filter data by date
df_power1 <- filter(df_power, Date == "1/2/2007")
df_power2 <- filter(df_power, Date == "2/2/2007")
df_power <- rbind(df_power1, df_power2)

# Convert the required column to the correct unit (based on the reference charts)
df_power <- mutate(df_power, Global_active_power_kw = as.numeric(Global_active_power) / 500)

# Open graphic device
png("plot1.png", width=480, height=480)

# Plot and format the graph as required
hist(df_power$Global_active_power_kw, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

dev.off()

