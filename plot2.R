## Plot 2: Global Active Power vs. Time

plotdata <- read.csv("plot_data.csv")

## convert Date/Time strings into numbers
xdata <- as.integer(as.POSIXct(paste(plotdata$Date, plotdata$Time)))

## Custom X-Axis Ticks/Labels
xTickDates <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
xAxisTicks <- as.integer(xTickDates)
xAxisLabels <- weekdays(xTickDates, abbreviate = TRUE)

## open plot device
png(file = "plot2.png")

## plot data
with (plotdata,
    plot(timedata, Global_active_power, type="l", ann=FALSE, axes=FALSE))

## draw box and axes
box()
axis(side=1,at=axisdates,labels=axislabels)
title(ylab="Global Active Power (kilowatts)")
axis(side=2)

## close plot device
dev.off()

