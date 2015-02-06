# install library 'sqldf', if necessary
# install.packages("sqldf")

# load library
library(sqldf)

# download file, if not exists
zip_filename = "household_power_consumption.zip"
txt_filename = "household_power_consumption.txt"
link = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(zip_filename)) {
    download.file(
        link,
        destfile = zip_filename,
        method = "curl"
    )
    unzip(zip_filename, txt_filename)
}

# select data from file to data frame with filtering
df <- read.csv.sql(
    txt_filename,
    sql="select * from file where Date in ('1/2/2007', '2/2/2007')",
    sep=";"
)


# create png file
png("plot4.png", width = 480, height = 480)

# convert Date and Time strings to DateTime
df$datetime <- strptime(
    paste(df$Date, df$Time, sep = " "),
    format = "%d/%m/%Y %H:%M:%S",
    tz = "GMT"
)

par(mfcol=c(2,2))

# create first plot
plot(
    df$datetime,
    df$Global_active_power,
    type = "l",
    ylab = "Global Active Power",
    xlab = ""
)

# create second plot
plot(
    df$datetime,
    df$Sub_metering_1,
    type = "l",
    ylab = "Energy sub metering",
    xlab = ""
)
lines(df$datetime, df$Sub_metering_2, col="red")
lines(df$datetime, df$Sub_metering_3, col="blue")
legend(
    "topright",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"),
    lwd=1
)

# create third plot
plot(
    df$datetime,
    df$Voltage,
    type = "l",
    ylab = "Voltage",
    xlab = "datetime"
)

# create fourth
plot(
    df$datetime,
    df$Global_reactive_power,
    type = "l",
    ylab = "Global_reactive_power",
    xlab = "datetime"
)

dev.off()
