##Reads .rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


##Calculates total emissions per year
totalyear <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))


##Plots in a .png file
png(filename = "plot1.png", width = 480, height = 480)
barplot(totalyear, ylab = "Total PM2.5 emissions in tons", xlab = "Year", 
        main = "Total PM2.5 emissions in the United States from 1999 to 2008")
dev.off()
