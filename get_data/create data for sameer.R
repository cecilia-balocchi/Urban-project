setwd("~/Dropbox (Penn)/STAT/STAT research/Urban/")
load('data/crime/crimes.new2018.rdata')
variable = 'blockgroup'
ncols = 12
ucr_unique <- unique(crimes.new$ucr_general)

total_df <- data.frame(X = rep(1:1336, each = ncols), year = rep(2006:(ncols+2005),1336))
total_df$X <- as.factor(total_df$X)
p <- 3
for(ucr in ucr_unique){
  crimes_selected <- crimes.new[crimes.new$ucr_general == ucr, ]
  table_selected <- table(factor(crimes_selected[,variable], lev = 1:1336),factor(crimes_selected$year, lev = 2006:(ncols+2005)))
  table_selected <-table_selected[,1:ncols]
  n <- dim(table_selected)[1]
  table_selected <- cbind(1:n,table_selected)
  colnames(table_selected)[1] <- variable
  table_selected <- as.data.frame(table_selected)
  total <- table_selected
  c_y <-tbl_df(total)
  t1 <- c_y[rep(1:dim(c_y)[1],ncols),]
  t2 <- arrange_(t1, .dots = variable)
  t3 <- mutate(t2,year = rep(2006:(ncols+2005),dim(c_y)[1]))
  t4 <- mutate(t3,violent = NA)
  for(y in 2006:(ncols+2005)){
    str <- paste0("",y)
    t4[t4$year==y,]$violent <- c_y[,str][[1]]
  }
  years <- "year"
  violents <- "violent"
  t4 <- dplyr::select_(t4,.dots = c("variable","years","violents"))
  t4[,variable][[1]] <- as.factor(t4[,variable][[1]])
  t6 <- mutate_(t4, .dots = setNames(list(variable), "X"))
  t6 <- dplyr::select(t6,X,year,violent)
  
  total_df$newvar <- t6$violent
  colnames(total_df)[p] <- paste0("ucr_",ucr)
  cat(p, " ")
  p <- p+1
}

dim(total_df)
total_df <- total_df[,1:28]

write.csv(total_df, "crime_type_year.csv", sep = ',', col.names = T)
