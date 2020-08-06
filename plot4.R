##Reads .rds files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

##Filters rows for coal source
coalsource <- grepl("[Cc]oal", SCC$SCC.Level.Three)
SCCcoal <- subset(SCC$SCC, coalsource)
emissionscoal <- subset(NEI, NEI$SCC %in% SCCcoal, select = c(fips, Emissions, type, year))


##Calculates emissions per year for coal source
totalyear <- with(emissionscoal, tapply(Emissions, year, sum, na.rm = TRUE))


##Plots in a .png file
png(filename = "plot4.png", width = 480, height = 480)
barplot(totalyear, ylab = "PM2.5 emissions in tons", xlab = "Year", 
        main = "PM2.5 emissions in the United States \n for coal related sources from 1999 to 2008")
dev.off()
