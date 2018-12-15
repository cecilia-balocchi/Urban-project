library(rgdal)

path_to_downloaded_shapefile <- "data/shapefile/Census_Block_Groups_2010/"
path_to_imported_shapefile <- "data/shapefile/"
file_name <- "Census_Block_Groups_2010.shp"
new_name <- "phillyblockgroup2"
str <- paste0(path_to_downloaded_shapefile, file_name)
if(file.exists(str)){
	obj <- readOGR(str)
	save(obj, file = paste0(path_to_imported_shapefile,new_name))
}


path_to_downloaded_shapefile <- "data/shapefile/tracts_pc2010/"
path_to_imported_shapefile <- "data/shapefile/"
file_name <- "tl_2010_42101_tract10.shp"
new_name <- "phillytracts"
str <- paste0(path_to_downloaded_shapefile, file_name)
if(file.exists(str)){
	obj <- readOGR(str)
	save(obj, file = paste0(path_to_imported_shapefile,new_name))
}

path_to_downloaded_shapefile <- "data/shapefile/Census_Blocks_2010/"
path_to_imported_shapefile <- "data/shapefile/"
file_name <- "Census_Blocks_2010.shp"
new_name <- "phillyblock"
str <- paste0(path_to_downloaded_shapefile, file_name)
if(file.exists(str)){
	obj <- readOGR(str)
	save(obj, file = paste0(path_to_imported_shapefile,new_name))
}