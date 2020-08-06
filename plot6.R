##Reads .rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

##Filters rows for vehicle sector
vehiclesector <- grepl("[Vv]ehicle", SCC$EI.Sector)
SCCvehicle <- subset(SCC$SCC, vehiclesector)
emissionsvehicle <- subset(NEI, NEI$SCC %in% SCCvehicle, select = c(fips, Emissions, type, year))


##Filters rows for Baltimore
emissionsBaltimore <- subset(emissionsvehicle, fips == "24510")


##Calculates total emissions per year for Baltimore
totalbaltimore <- with(emissionsBaltimore, tapply(Emissions, year, sum, na.rm = TRUE))


##Filters rows for Los Angeles County
emissionsLosAngeles <- subset(emissionsvehicle, fips == "06037")


##Calculates total emissions per year for Los Angeles County
totalLosAngeles <- with(emissionsLosAngeles, tapply(Emissions, year, sum, na.rm = TRUE))


##Plots in a .png file
png(filename = "plot6.png", width = 960, height = 480)
par(mfrow = c(1,2))
barplot(totalbaltimore, ylab = "Total PM2.5 emissions in tons", xlab = "Year", ylim = c(0,4500), 
        main = "PM2.5 emissions in Baltimore City for \n vehicle sector from 1999 to 2008")
barplot(totalLosAngeles, ylab = "Total PM2.5 emissions in tons", xlab = "Year", ylim = c(0,4500),
        main = "PM2.5 emissions in Los Angeles County for \n vehicle sector from 1999 to 2008")
dev.off()
