## Read data from working directory. 
## Since assignment is on exploring data, unzipped the file manually instead of using code.  
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 2. Have total emissions from PM2.5 decreased in 
## the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

# extract emissions data from Beltimore City only
NEI_Beltimore <- NEI[NEI$fips == "24510", ]

# sum all emmissions for each year
EmissionsByYear_Beltimore <- tapply(NEI_Beltimore$Emissions, NEI_Beltimore$year, sum)

# line plot 
par("mar"=c(5.1, 4.5, 4.1, 2.1))

plot(EmissionsByYear_Beltimore, type = "l", xlab = "Year", 
     main = "Total Emissions in Baltimore City\n(1999 to 2008)", 
     ylab = expression('Total PM'[2.5]*" Emission"), 
     xaxt ='n')
axis(1, at=1:4, labels=rownames(EmissionsByYear_Beltimore))

dev.copy(png, file = "plot2.png")
dev.off()
