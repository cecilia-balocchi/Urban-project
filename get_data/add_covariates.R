# In this code I will add covariates and
# transform certain variables with log/sqrt
# transformation. 
# I will then construct data_new.
# Update 9/22: now that poverty and income are correct, the correct transformations are
# income) and sqrt(poverty) - I saved the correct data_new
# Update 9/24: we can create data_new using either crime_agr2018 or data_agr (doing the first here)
library(ape)
library(ggplot2)
library(ggmap)
library(maptools)
library(dplyr)
library(spdep)

setwd("~/Dropbox (Penn)/STAT/STAT research/Urban/")
# load("data/data_agr.rdata")
# load("data/data_mod.rdata")
load("data/shapefile/phillyblockgroup")
load("data/crime/crime_agr2018.rdata")

# using the data Colman gave me in phillyblockgroup
tmp <- phillyblockgroup@data[,c("income13", "poverty13", "vacantprop", "comresprop", "total", "segregationmetric", "GEOID10")]
tmp2 <- crime_agr2018[,c("X", "GEOID10", "year", "year19", "tr.violent")]

tmp.rep <- tmp[match(tmp2$GEOID10, tmp$GEOID10),]
# all.equal(tmp2$GEOID10, tmp.rep$GEOID10)

data_new <- tmp2 %>% mutate(log.income13 = log(tmp.rep$income13), sqrt.poverty13 = sqrt(tmp.rep$poverty13), sqrt.vacantprop = sqrt(tmp.rep$vacantprop), 
                            sqrt.comresprop = sqrt(tmp.rep$comresprop), pop_total = tmp.rep$total, segregation = tmp.rep$segregationmetric)

save(data_new, file = "data/data_new.rdata")
# setwd("~/Dropbox (Penn)/Urban Project/parametric/")
# save(data_new, file = "data/data_new.rdata")



## The reason for this transformation can be found here:
test <- tmp2 %>% mutate(income13 = tmp.rep$income13, poverty13 = tmp.rep$poverty13, vacantprop = tmp.rep$vacantprop, 
                        comresprop = tmp.rep$comresprop, pop_total = tmp.rep$total, segregation = tmp.rep$segregationmetric)

test <- test %>% dplyr::select(X, year, tr.violent, income13, poverty13, segregation, vacantprop, comresprop, pop_total) %>% 
  group_by(X) %>% summarize(trviolent = mean(tr.violent), income = mean(income13), poverty = mean(poverty13),
                            segr = mean(segregation), vac = mean(vacantprop), comres = mean(comresprop), pop = mean(pop_total))
pairs(trviolent ~ income + poverty + segr + vac + comres + pop, data = test, pch='.')
pairs(trviolent ~ log(income) + sqrt(poverty) + segr + sqrt(vac) + sqrt(comres) + pop, data = test, pch='.')