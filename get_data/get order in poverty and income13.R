# we construct poverty metric and income metric.
setwd("~/Dropbox (Penn)/STAT/STAT research/Urban/")
load("data/shapefile/phillyblockgroup")
library(dplyr)

#### poverty 13
poverty_13 <- read.csv("data/poverty2013ratioincome/ACS_13_5YR_C17002_with_ann.csv", header = T, skip = 1, colClasses = c("character","factor","character",rep("integer",16)))
# View(poverty_13)

# we are interested only in the estimates and the total (we exclude the sd)
cols <- c(6,8,10,12,14,16,18,4)
colnames(poverty_13)[cols]
poverty_13cols <- poverty_13[,c(2,cols)]
colnames(poverty_13cols) <- c("GEOID10","under .50",".50 to .99","1.00 to 1.24","1.25 to 1.49","1.50 to 1.84", "1.85 to 1.99", "2.00 and over", "total")

# we remove the block groups that have a total population less than 10
few_pop <- which(poverty_13cols[,9]<10)
poverty_13cols[few_pop,9] <- NA

# we compute the proportion of people in each category
proportions <- poverty_13cols[,2:8]/poverty_13cols[,9]
# these are the weights we'll use to compute our measure
weights <- (6:0)/6
pov <- as.matrix(proportions, nrow = dim(proportions)[1]) %*% weights
pov <- as.numeric(pov)
head(pov)
poverty_13cols$poverty <- pov
head(poverty_13cols)

# we need to get the right order to match the poverty here to the neighborhoods of the main dataframe
order <- match(phillyblockgroup@data$GEOID10, poverty_13cols$GEOID10)
phillyblockgroup@data$poverty13 <- poverty_13cols[order,10]

# old non-efficient way of doing the same thing
# re_order <- rep(NA, 1336)
# for(i in 1:1336){
#   str <- phillyblockgroup@data$GEOID10[i]
#   tmp <- which(poverty_13cols$GEO.id2 == str)
#   if(length(tmp)!=1) cat(i, " ")
#   re_order[i] <- tmp
# }
# phillyblockgroup@data$poverty13 <- pov[re_order]

#### income 13
income_13 <- read.csv("data/income2013percapita/ACS_13_5YR_B19301.csv", header = T) #this is the one colman used!
# income_13 <- read.csv("data/income2013medianhousehold/ACS_13_5YR_B19013.csv", header = T) # medianincome has much more NAs
income_13 <- income_13[,c(2,4)]
colnames(income_13) <- c("GEOID10", "income")

# row 1335 of phillyblockgroup@data is missing in income_13! Check:
tmp <- match(phillyblockgroup@data$GEOID10, income_13$GEOID10)
which(is.na(tmp))
tmp[1336] # = 1335
# fix it:
row1336 <- income_13[1335,]
income_13[1335,1] <- levels(phillyblockgroup@data$GEOID10)[1335]
income_13[1335,2] <- NA
income_13 <- rbind(income_13,row1336)
rownames(income_13)[1336] <- "1336"
income_13$GEOID10 <- as.factor(income_13$GEOID10)
income_13[1334:1336,]

# we need to get the right order to match the income here to the neighborhoods of the main dataframe
order <- match(phillyblockgroup@data$GEOID10, income_13$GEOID10)
phillyblockgroup@data$income13 <- income_13[order,2]

save(phillyblockgroup, file = "data/shapefile/phillyblockgroup")
# setwd("/Users/cecib/Dropbox (Penn)/Urban Project/parametric/")
# save(phillyblockgroup, file = "data/shapefile/phillyblockgroup")