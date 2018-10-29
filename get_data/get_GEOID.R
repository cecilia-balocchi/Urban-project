setwd("/Users/cecib/Dropbox (Penn)/Urban Project/parametric/")
load("data/shapefile/phillyblockgroup")

library(stringr)
tr_char <- as.character(as.numeric(phillyblockgroup@data$censustract)*100)
phillyblockgroup@data$TRACTCE10 <- as.factor(str_pad(tr_char, width = 6, side = "left", pad = "0"))
phillyblockgroup@data$BLKGRPCE10 <- as.factor(phillyblockgroup@data$blockgroup)
phillyblockgroup@data$GEOID10 <- as.factor(paste0("42101",phillyblockgroup@data$TRACTCE10,phillyblockgroup@data$BLKGRPCE10))

save(phillyblockgroup, file = "data/shapefile/phillyblockgroup")
# setwd("/Users/cecib/Dropbox (Penn)/STAT/STAT research/Urban/")
# save(phillyblockgroup, file = "data/shapefile/phillyblockgroup")
