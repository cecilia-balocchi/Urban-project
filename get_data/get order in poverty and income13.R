# we construct poverty metric and income metric.
setwd("/Users/cecib/Dropbox (Penn)/STAT/STAT research/Urban/")
load("data/shapefile/phillyblockgroup")
library(dplyr)
poverty_13 <- read.csv("data/poverty2013ratioincome/ACS_13_5YR_C17002_with_ann.csv", header = T)
# View(poverty_13)

cols <- c(6,8,10,12,14,16,18,4)

#### poverty 13
poverty_13 <- poverty_13[2:1337,]
for(i in 1:3) poverty_13[,i] <- as.character(poverty_13[,i])
for(i in 4:19) poverty_13[,i] <- as.numeric(levels(poverty_13[,i]))[poverty_13[,i]]
poverty_13cols <- poverty_13[,c(1:3,cols)]
colnames(poverty_13cols)[4:11] <- c("under .50",".50 to .99","1.00 to 1.24","1.25 to 1.49","1.50 to 1.84", "1.85 to 1.99", "2.00 and over", "total")
few_pop <- which(poverty_13cols[,11]<10)
poverty_13cols[few_pop,11] <- NA
temp <-poverty_13cols[,4:10]/poverty_13cols[,11]
vec <- (6:0)/6
pov <- as.matrix(temp, nrow = dim(temp)[1]) %*% vec
pov <- as.numeric(pov)
str(pov)
poverty_13cols$poverty <- pov
str(poverty_13cols)

##

# this should be done with a match
re_order <- rep(NA, 1336)
for(i in 1:1336){
  str <- phillyblockgroup@data$GEOID10[i]
  tmp <- which(poverty_13cols$GEO.id2 == str)
  if(length(tmp)!=1) cat(i, " ")
  re_order[i] <- tmp
}

phillyblockgroup@data$poverty13 <- pov[re_order]

#### income 13
income_13 <- read.csv("data/income2013percapita/ACS_13_5YR_B19301.csv", header = T) #this is the one colman used!
# income_13 <- read.csv("data/income2013medianhousehold/ACS_13_5YR_B19013.csv", header = T) # medianincome has much more NAs
for(i in 1:3) income_13[,i] <- as.character(income_13[,i])
income_13 <- income_13[,1:4]

# row 1335 is missing!

row1336 <- income_13[1335,]
income_13[1335,1:3] <- poverty_13cols[1335,1:3]
income_13[1335,4] <- NA
income_13 <- rbind(income_13,row1336)
rownames(income_13)[1336] <- "1336"
income_13[1334:1336,]

re_order <- rep(NA, 1336)
for(i in 1:1336){
  str <- phillyblockgroup@data$GEOID10[i]
  tmp <- which(income_13$GEO.id2 == str)
  if(length(tmp)!=1){
    cat(i, " ")
  } else {
    re_order[i] <- tmp 
  }
}

phillyblockgroup@data$income13 <- income_13[re_order,4]

save(phillyblockgroup, file = "data/shapefile/phillyblockgroup")
# setwd("/Users/cecib/Dropbox (Penn)/Urban Project/parametric/")
# save(phillyblockgroup, file = "data/shapefile/phillyblockgroup")