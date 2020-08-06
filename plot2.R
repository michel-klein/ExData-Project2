##Reads .rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


##Filters rows for Baltimore
emissionsBaltimore <- subset(NEI, fips == "24510", select = c(fips, Emissions, year))


##Calculates total emissions per year for Baltimore
totalyear <- with(emissionsBaltimore, tapply(Emissions, year, sum, na.rm = TRUE))


##Plots in a .png file
png(filename = "plot2.png", width = 480, height = 480)
barplot(totalyear, ylab = "Total PM2.5 emissions in tons", xlab = "Year", 
        main = "Total PM2.5 emissions in Baltimore City from 1999 to 2008")
dev.off()
