library(wbstats)
library(data.table)
library(googleVis)
# Download World Bank data and turn into data.table
myDT <- data.table(
  wb(indicator = c("SP.POP.TOTL",
                   "SP.DYN.LE00.IN",
                   "SP.DYN.TFRT.IN"), mrv = 60)
)  
# Download country mappings
countries <- data.table(wbcountries())
# Set keys to join the data sets
setkey(myDT, iso2c)
setkey(countries, iso2c)
# Add regions to the data set, but remove aggregates
myDT <- countries[myDT][ ! region %in% "Aggregates"]
# Reshape data into a wide format
wDT <- reshape(
  myDT[, list(
    country, region, date, value, indicator)], 
  v.names = "value", 
  idvar=c("date", "country", "region"), 
  timevar="indicator", direction = "wide")
# Turn date, here year, from character into integer
wDT[, date := as.integer(date)]
setnames(wDT, names(wDT),
         c("Country", "Region",
           "Year", "Population",
           "Fertility", "LifeExpectancy"))
M <- gvisMotionChart(wDT, idvar = "Country",
                     timevar = "Year",
                     xvar = "LifeExpectancy",
                     yvar = "Fertility",
                     sizevar = "Population",
                     colorvar = "Region")
# Ensure Flash player is available an enabled
plot(M)