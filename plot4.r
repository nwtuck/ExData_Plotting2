## Read data from working directory. 
## Since assignment is on exploring data, unzipped the file manually instead of using code.  
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 4. Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999-2008?

# extract SCC for coal combustion-related sources by searching for the word "Coal" and "Comb " 
CoalCombSCC <- SCC[grepl("Comb ", SCC$Short.Name) & grepl("Coal", SCC$Short.Name) ,]

# extract emissions data of coal combustion-related sources
NEI_CoalComb <- NEI[NEI$SCC %in% CoalCombSCC$SCC, ]

# sum emmissions for each year
CoalCombEmissionsByYear <- tapply(NEI_CoalComb$Emissions, NEI_CoalComb$year, sum)


# line plot 
par("mar"=c(5.1, 4.5, 4.1, 2.1))

plot(CoalCombEmissionsByYear, type = "l", xlab = "Year", 
     main = "Total Coal Combustion-Related Source\nEmissions in the US (1999 to 2008)", 
     ylab = expression('Total PM'[2.5]*" Emission"), 
     xaxt ='n')
axis(1, at=1:4, labels=rownames(CoalCombEmissionsByYear))

dev.copy(png, file = "plot4.png")
dev.off()
