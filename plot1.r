## Read data from working directory. 
## Since assignment is on exploring data, unzipped the file manually instead of using code.  
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

# summary(factor(NEI$Pollutant))
# PM25-PRI 
# 6497651 

# summary(factor(NEI$year))
#    1999    2002    2005    2008 
# 1108469 1698677 1713850 1976655 

# sum all emmissions for each year
EmissionsByYear <- tapply(NEI$Emissions, NEI$year, sum)

# reduce Emissions total to unit of million tons
EmissionsByYear <- EmissionsByYear/1000000

# line plot 
par("mar"=c(5.1, 4.5, 4.1, 2.1))

plot(EmissionsByYear, type = "l", xlab = "Year", 
     main = "Total Emissions in the US (1999 to 2008)", 
     ylab = expression('Total PM'[2.5]*" Emission, in Million Tons"), 
     xaxt ='n')
axis(1, at=1:4, labels=rownames(EmissionsByYear))

dev.copy(png, file = "plot1.png")
dev.off()
