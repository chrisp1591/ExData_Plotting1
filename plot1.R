## Plot 1: Histogram of Global Active Power

plotdata <- read.csv("plot_data.csv")
png(file = "plot1.png")
with(plotdata,
     hist(Global_active_power, col = "orangered",
          xlab = "Global Active Power (kilowatts)",
          main = "Global Active Power"))
dev.off()
