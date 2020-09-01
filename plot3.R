## Plot 3: Sub Metering 1, 2, 3 vs. Time

plotdata <- read.csv("plot_data.csv")

## convert Date/Time strings into numbers
xdata <- as.integer(as.POSIXct(paste(plotdata$Date, plotdata$Time)))

## Custom X-Axis Ticks/Labels
xTickDates <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
xAxisTicks <- as.integer(xTickDates)
xAxisLabels <- weekdays(xTickDates, abbreviate = TRUE)

## Set up Y-Axis data, labels, and colors
ydata <- with(plotdata, list(Sub_metering_1, Sub_metering_2, Sub_metering_3))
yLabels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
yColors <- c("black", "orangered", "blue")

## open plot device
png(file = "plot3.png")

## Define the plot area
with(plotdata, plot(xdata,pmax(Sub_metering_1,Sub_metering_2,Sub_metering_3), 
                    type="n", ann=FALSE, axes=FALSE))
box()

## Draw and label axes
axis(side=1,at=axisdates,labels=axislabels)
title(ylab="Energy sub metering")
axis(side=2)

## plot data
for (i in 1:3) {
    lines(xdata, ydata[[i]], col = yColors[i])
}

## draw legend
legend("topright",legend=yLabels,col=yColors,lty=1)

## close plot device
dev.off()

