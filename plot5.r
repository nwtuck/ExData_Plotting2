## Read data from working directory. 
## Since assignment is on exploring data, unzipped the file manually instead of using code.  
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# extract SCC for coal combustion-related sources by searching for the word "Coal" and "Comb " 
vehicleSCC <- SCC[SCC$Data.Category=="Onroad",]

# extract emissions data from Beltimore only
NEI_Beltimore <- NEI[NEI$fips == "24510", ]

# extract emissions data of coal combustion-related sources
NEI_vehicleBeltimore <- NEI_Beltimore[NEI_Beltimore$SCC %in% vehicleSCC$SCC, ]

# sum emmissions for each year
EmissionsByYear_Beltimore <- tapply(NEI_vehicleBeltimore$Emissions, 
                                    NEI_vehicleBeltimore$year, sum)

# line plot 
par("mar"=c(5.1, 4.5, 4.1, 2.1))

plot(EmissionsByYear_Beltimore, type = "l", xlab = "Year", 
     main = "Total Emissions From Motor Vehicle Sources\n in Baltimore City (1999 to 2008)", 
     ylab = expression('Total PM'[2.5]*" Emission"), 
     xaxt ='n')
axis(1, at=1:4, labels=rownames(CoalCombEmissionsByYear))

dev.copy(png, file = "plot5.png")
dev.off()
