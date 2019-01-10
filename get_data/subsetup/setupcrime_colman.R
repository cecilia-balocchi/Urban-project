setwd("C:/Users/Cecilia/Google Drive/STAT/STAT research/Urban")

landuse.load = FALSE

## Ceci you probably don't have this?
source("code/plotcode/plotinit.R")

##------------------------------------##
### crime data

## import
crime.pre <- read.csv("data/csv/crimeupdatedcsv.csv",
                  sep = ",",
                  header = T,
                  stringsAsFactors = F)

## create coords
temp.point <- substr(crime.pre$SHAPE, 8, nchar(crime.pre$SHAPE))
temp.space <- regexpr(" ", temp.point)
temp.pointX <- as.numeric(substr(temp.point, 1, temp.space - 1))
temp.pointY <- as.numeric(substr(temp.point, temp.space + 1, nchar(temp.point) - 1))

## actually they have the same NAs, but just in case
rem.ind.points <- is.na(temp.pointX) | is.na(temp.pointY)

## want to make this exact same as old file. Remove crap points, keep order:
crimes.new <- crime.pre[!rem.ind.points,c('DC_DIST', 'PSA', 'UCR_GENERAL',
                                         'TEXT_GENERAL_CODE')]
crimes.new$POINT_X <- temp.pointX[!rem.ind.points]
crimes.new$POINT_Y <- temp.pointY[!rem.ind.points]

## crime type oh yes
crimetypes <- c('murder', 'rape', 'robbery', 'assault',
                'burglary', 'theft', 'motortheft',
                'otherassault', 'arson', 'forgery',
                'fraud', 'embezzlement', 'receivestolen',
                'vandalism', 'weaponviolation',
                'prostitution', 'sexoffense', 'drugviolation',
                'gambling', 'familyoffense', 'dui', 'liquorlaw',
                'publicdrunk', 'disorderly', 'vagrancy',
                'other')

crimeframe <- data.frame(ucr = sort(unique(crime.pre$UCR_GENERAL)),
                         crimetype = crimetypes)

temp.crimetype = crimeframe$crimetype[match(crime.pre$UCR_GENERAL, crimeframe$ucr)]

crimes.new$crimetype = temp.crimetype[!rem.ind.points]

## there's a timedate col, but it's in 12h... so I won't use it
temp.date = as.Date(crime.pre$DISPATCH_DATE)
temp.time = crime.pre$DISPATCH_TIME

crimes.new$date = temp.date[!rem.ind.points]

temp.timedate = as.POSIXct(paste(temp.date, temp.time), tz = 'EST')
crimes.new$timedate = temp.timedate[!rem.ind.points]

## add time with any given Sunday (only so that it has a Sunday zero point
## for week plotting)
temp.time <- format(crimes.new$timedate, format = "%H:%M:%S")
given.sunday <- '2016-05-08'
crimes.new$time <- as.POSIXct(paste(given.sunday, temp.time),  tz = "EST")

## add weekday
crimes.new$weekday <- weekdays(crimes.new$timedate)

##------------------------------------##

## add block, blockgroup

## CECI: this is potentially diff from what you have!

## spatial situ
pts <- SpatialPoints(crimes.new[ ,c('POINT_X', 'POINT_Y')])
## now over - lists
## you'd save time by just doing blocks and then matching blocks to
## blockgroups, but not much time, so copying this code was easier
## than writing a simple match
crimebyblock <- over(phillyblock, pts, returnList = T)
crimebyblockgroup <- over(phillyblockgroup, pts, returnList = T)

## we want to record which block a crime happens in, in the dataframe
crimes.new$block <- NA
crimes.new$blockgroup <- NA

## ## easy code, but slow:
## for(i in 1:length(crimebyblock)){
##     crimes$block[crimebyblock[[i]]] = i
## }

## replace with:

crimevector <- unlist(crimebyblock)
crimeblocklength <- lapply(crimebyblock, length)

crimeind.temp <- c(0, cumsum(crimeblocklength))
for(i in 1:length(crimebyblock)){
    temp.index <- (crimeind.temp[i] + 1): (crimeind.temp[i + 1])
    crimes.new$block[crimevector[temp.index]] = i
    Iprint(i, 10)
}

crimevector <- unlist(crimebyblockgroup)
crimeblockgrouplength <- lapply(crimebyblockgroup, length)

crimeind.temp <- c(0, cumsum(crimeblockgrouplength))
for(i in 1:length(crimebyblockgroup)){
    temp.index <- (crimeind.temp[i] + 1): (crimeind.temp[i + 1])
    crimes.new$blockgroup[crimevector[temp.index]] = i
    Iprint(i, 10)
}

##------------------------------------##

## add year
temp.year = format(crimes.new$date, '%Y')
crimes.new$year <- as.numeric(temp.year)

## sort the whole thing
crimes.new <- crimes.new[order(crimes.new$timedate),]

## a small fraction (863 or 0.04%) aren't in Philly (according to our shapefile)
## remove them
## (note: each crime either has both a block and blockgroup, or neither)
crimes.new <- crimes.new[!is.na(crimes.new$block),]

##------------------------------------##

save(crimes.new, file = 'data/crime/crimes.new.rdata')

##------------------------------------##

## now we want to tabulate crimes by block, and blockgroup
bbg <- c('block', 'blockgroup')
temp.wide.pre <- list()
temp.wide <- list()

for(bg in bbg){
    temp.wide.pre[[bg]] <- table(crimes.new[,bg], crimes.new$UCR_GENERAL)

    ## need to add back zero rows
    ## i.e. blocks with no recorded crimes
    ## first add them at the bottom, get the names of the nonempties
    rowsused <- as.numeric(rownames(temp.wide.pre[[bg]]))
    temp.wide[[bg]] <- rbind(temp.wide.pre[[bg]],
                             matrix(0,
                                    nrow(phillydata[[bg]]) - length(rowsused),
                                    ncol(temp.wide.pre[[bg]])))

    ## give the blank rows names
    rownames(temp.wide[[bg]]) <- c(rowsused, (1:nrow(phillydata[[bg]]))[-rowsused])

    ## order by name
    temp.wide[[bg]] <- temp.wide[[bg]][order(as.numeric(rownames(temp.wide[[bg]]))),]

    temp.wide[[bg]] <- as.data.frame(temp.wide[[bg]])
}

## add crimes to name, if you want!
temp.names = names(temp.wide[['block']])
names(temp.wide[['block']]) <- paste0(crimeframe$crimetype, '.', temp.names)

temp.names = names(temp.wide[['blockgroup']])
names(temp.wide[['blockgroup']]) <- paste0(crimeframe$crimetype, '.', temp.names)

save(temp.wide, file = "data/cleaned/crime.temp.wide.rdata")

