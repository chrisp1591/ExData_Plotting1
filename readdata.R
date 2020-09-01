## Read and pre-process project data

## Dataset: Electric power consumption [20MB]
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## The dataset has 2,075,259 rows and 9 columns. First calculate a rough
## estimate of how much memory the dataset will require in memory before reading
## into R. Make sure your computer has enough memory (most modern computers
## should be fine). 

## We will only be using data from the dates 2007-02-01 and
## 2007-02-02. One alternative is to read the data from just those dates rather
## than reading in the entire dataset and subsetting to those dates.

## I wrote out the pre-processed data subset to a csv file and used
## the csv file (plot_data.csv) for the rest of the project.

library(readr)

datafile <- "data/household_power_consumption.txt"
datarows <- 2075259
colspec <- spec_delim(datafile, ";", na="?", n_max=100)
colnames <- names(colspec$cols)
colspec$cols$Date <- col_date(format = "%d/%m/%Y")

datespec <- cols_only(Date=col_date("%d/%m/%Y"))
fromdate <- as.Date("2007-02-01")
thrudate <- as.Date("2007-02-02")

dateonly <- read_delim(datafile, ";", na="?", n_max=100, 
                    col_types=datespec)
firstdate <- dateonly[[1,1]]

if(firstdate < fromdate) {
    date_skip <- as.integer(fromdate - firstdate - 1) * 1440
    date_nmax <- as.integer(thrudate - firstdate + 1) * 1440 - date_skip
}

roughdata <- read_delim(datafile, ";", na="?", 
                       skip = date_skip, n_max = date_nmax, 
                       col_names = colnames, col_types = colspec)

plotdata <- subset(roughdata, Date >= fromdate & Date <= thrudate)

write_csv(plotdata,"plot_data.csv")
