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
png("plot1.png", width = 480, height = 480)

# create hist
hist(
    df$Global_active_power,
    main = "Global Active Power",
    xlab = "Global Active Power (kilowatts)",
    col = "red",
    border = "black"
)
dev.off()