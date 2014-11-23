## Read data from working directory. 
## Since assignment is on exploring data, unzipped the file manually instead of using code.  
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

# extract SCC for coal combustion-related sources by searching for the word "Coal" and "Comb " 
vehicleSCC <- SCC[SCC$Data.Category=="Onroad",]

# extract emissions data from Beltimore and LA only
NEI_BeltimoreLA <- NEI[NEI$fips == "24510" | NEI$fips == "06037", ]

# give fips number meaingful name 
NEI_BeltimoreLA[NEI_BeltimoreLA$fips == "24510", "city" ] <- "Beltimore City"
NEI_BeltimoreLA[NEI_BeltimoreLA$fips == "06037", "city" ] <- "Los Angeles County"

# extract vehicle emissions data of Beltimore and LA
NEI_vehicleBeltimoreLA <- NEI_BeltimoreLA[NEI_BeltimoreLA$SCC %in% vehicleSCC$SCC, ]

# line plot, vehicle emissions faceted by city
# the same comparison can be achieved by plotting both lines without facet
# facet was used just for practise
par("mar"=c(5.1, 4.5, 4.1, 2.1))

ggplot(NEI_vehicleBeltimoreLA, aes(year, Emissions, color = city)) + 
  geom_line(stat = "summary", fun.y = "sum") +
  facet_grid( . ~ city) +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Total Emissions from Vehicles Sources in\nBaltimore City and Los Angeles Country (1999 to 2008)")
  
dev.copy(png, file = "plot6.png")
dev.off()
