# we construct poverty metric and income metric.
setwd("~/Dropbox (Penn)/STAT/STAT research/Urban/")
load("data/shapefile/phillyblockgroup")
library(dplyr)

#### poverty 13
# since I downloaded this file "with annotations"
poverty_13 <- read.csv("data/ACS_13_5YR_C17002/ACS_13_5YR_C17002_with_ann.csv", header = T, skip = 1, colClasses = c("character","factor","character",rep("integer",16)))
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

#### income 13
income_13 <- read.csv("data/ACS_13_5YR_B19301/ACS_13_5YR_B19301.csv", header = T) #this is the one colman used, income per capita!
# income_13 <- read.csv("data/ACS_13_5YR_B19013/ACS_13_5YR_B19013.csv", header = T) # median income per household has much more NAs
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

#### population total and segregation
race <- read.csv("data/DEC_10_SF1_P5/DEC_10_SF1_P5_with_ann.csv", header = T, skip = 1, colClasses = c("character","factor","character",rep("integer",17)))
## total
total <- race[,c(2,4)]
colnames(total) <- c("GEOID10", "total")

order <- match(phillyblockgroup@data$GEOID10, total$GEOID10)
phillyblockgroup@data$total <- total[order,2]
## segregation

# white corresponds to "Not.Hispanic.or.Latino....White.alone" (column 6)
# black corresponds to "Not.Hispanic.or.Latino....Black.or.African.American.alone" (column 7)
# asian corresponds to "Not.Hispanic.or.Latino....Asian.alone" (column 9)
# other corresponds to the sum of "Not.Hispanic.or.Latino....American.Indian.and.Alaska.Native.alone", 
# "Not.Hispanic.or.Latino....Native.Hawaiian.and.Other.Pacific.Islander.alone", 
# "Not.Hispanic.or.Latino....Some.Other.Race.alone", "Not.Hispanic.or.Latino....Two.or.More.Races"
# (columns 8,10,11,12)
# hispanic corresponds to "Hispanic.or.Latino." (column 13)

race2 <- race[,c(2,4,6,7,9,13)]
colnames(race2) <- c("GEOID10","total","white","black","asian","hispanic")
race2$other <- rowSums(race[,c(8,10,11,12)])
ratio <- race2[,3:7]/race2[,2]
overall <- colSums(race2[,2:7], na.rm = T)
overall <- overall[2:6]/overall[1]
overall <- array(rep(overall, each = nrow(ratio)), dim = dim(ratio))
race2$segregationmetric <- (rowSums(abs(ratio-overall))/2)

phillyblockgroup@data$segregationmetric <- race2[order,"segregationmetric"]
# optionally, add also the number of people per race:
phillyblockgroup@data <- cbind(phillyblockgroup@data, race2[order,3:7])



save(phillyblockgroup, file = "data/shapefile/phillyblockgroup")
# setwd("/Users/cecib/Dropbox (Penn)/Urban Project/parametric/")
# save(phillyblockgroup, file = "data/shapefile/phillyblockgroup")