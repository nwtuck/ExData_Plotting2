## Read data from working directory. 
## Since assignment is on exploring data, unzipped the file manually instead of using code.  
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## 3. Of the four types of sources 
## indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions 
## from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

# extract emissions data from Beltimore only
NEI_Beltimore <- NEI[NEI$fips == "24510", ]

# line plot, total emission by year and type
par("mar"=c(5.1, 4.5, 4.1, 2.1))

ggplot(NEI_Beltimore, aes(year, Emissions, color = type)) + 
  geom_line(stat = "summary", fun.y = "sum") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle("Total Emissions in Baltimore City (1999 to 2008)")

dev.copy(png, file = "plot3.png")
dev.off()
