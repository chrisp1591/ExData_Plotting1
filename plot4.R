## Plot 4: Multi-variable plot

plotdata <- read.csv("plot_data.csv")

## convert Date/Time strings into numbers
xdata <- as.integer(as.POSIXct(paste(plotdata$Date, plotdata$Time)))

## Custom X-Axis Ticks/Labels
xTickDates <- as.POSIXct(c("2007-02-01","2007-02-02","2007-02-03"))
xAxisTicks <- as.integer(xTickDates)
xAxisLabels <- weekdays(xTickDates, abbreviate = TRUE)

## datetimePlot: plot data with custom date/time axis
## ... is passed to title() for optional x-axis label

datetimePlot <- function(ydata, ylab, ...) {
    plot(timedata, ydata, type="l", ann=FALSE, axes=FALSE)
    box()
    axis(side=1,at=axisdates,labels=axislabels)
    title(ylab=ylab, ...)
    axis(side=2)
}

## Set up submetering labels and colors
smLabels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
smColors <- c("black", "orangered", "blue")

## open plot device
png(file = "plot4.png")

## set up 2x2 sub-plots
par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0,0,0,0))

## draw sub-plots
with (plotdata, {
    
    ## sub-plot 1: Global Active Power
    datetimePlot(Global_active_power, "Global Active Power")

    ## sub-plot 2: Voltage
    datetimePlot(Voltage, "Voltage", xlab = "datetime")
    
    ## sub-plot 3: Sub metering
    datetimePlot(Sub_metering_1, "Energy sub metering")
    lines(xdata, Sub_metering_2, col = smColors[2])
    lines(xdata, Sub_metering_3, col = smColors[3])
    legend("topright", legend = smLabels, col = smColors,
           lty=1, bty="n", cex=1)
    
    ## sub-plot 4: Global Reactive Power
    datetimePlot(Global_reactive_power, "Global_reactive_power",
                 xlab = "datetime")
})

## close plot device
dev.off()
