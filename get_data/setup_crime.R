library(dplyr)
library(MASS)
require(ggplot2)
require(ggmap)
require(scales)
require(rgeos)
library(spdep)
# setwd("~/Dropbox (Penn)/STAT/STAT research/Urban/")
# Assuming the working directory is set to the main project folder, say 'Urban', not to this 'get_data' subfolder or 'code'
# and assuming this folder contains 'code' and 'data'.
# 'data' contains 'csv' where I keep the raw file downloaded from the Philadelphia Police Department ('incidents_part1_part2.csv')
# 'data' contains 'shapefile', where I saved as R objects the shapefiles (read using 'readOGR')

source("code/get_data/clean_crime.R")
# crimes.new is a dataset where each row represents a crime and we save time/location and crimetype info
crimes.new <- clean_crime.from_csv("data/csv/incidents_part1_part2.csv", data_path = "data/")
save(crimes.new, file = 'data/crime/crimes.new2018.rdata')

## create crime_agr2018
# crime_agr is the dataframe I use to run the linear models: each line gives the number of crimes for a region and a year.
# use it with variable = "blockgroup" or "block" or "tract" (it will datasets aggregated at different levels).
crime_agr2018 <- aggregate_crime.from_rdata("data/crime/crimes.new2018.rdata", ncols = 12, variable = "blockgroup")
save(crime_agr2018, file = "data/crime/crime_agr2018.rdata")

load("data/crime/crime_agr2018.rdata")
# let's transform crime with inverse hyperbolic sine transformations
# log(yi+(yi2+1)1/2)
# http://worthwhile.typepad.com/worthwhile_canadian_initi/2011/07/a-rant-on-inverse-hyperbolic-sine-transformations.html
ihst <- function(y){
  log(y+(y^2+1)^0.5)
}
crime_agr2018$tr.violent <- ihst(crime_agr2018$violent)
crime_agr2018$log.violent <- log(crime_agr2018$violent+1)
crime_agr2018$year19 <- crime_agr2018$year-2005
save(crime_agr2018, file = "data/crime/crime_agr2018.rdata")

## create crime_tract2018
load("data/crime/crimes.new2018.rdata")
crime_tract2018 <- aggregate_crime.from_rdata("data/crime/crimes.new2018.rdata", ncols = 12, variable = "tract")
crime_tract2018$tr.violent <- ihst(crime_tract2018$violent)
crime_tract2018$log.violent <- log(crime_tract2018$violent+1)
crime_tract2018$year19 <- crime_tract2018$year-2005
save(crime_tract2018, file = "data/crime/crime_tract2018.rdata")
