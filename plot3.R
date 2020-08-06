library(ggplot2)

##Reads .rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

##Filters rows for Baltimore
emissionsBaltimore <- subset(NEI, fips == "24510", select = c(fips, Emissions, type, year))


##Calculates total emissions per year and per type
emissionstype <- aggregate(Emissions ~ year + type, emissionsBaltimore, sum)
emissionstype$year <- as.factor(emissionstype$year)

##Plots in a .png file
png(filename = "plot3.png", width = 960, height = 480)
q <- qplot(year, Emissions, data = emissionstype, facets = . ~ type, geom="col", main = "PM2.5 emissions in Baltimore City from 1999 to 2008 by source")
print(q)
dev.off()
