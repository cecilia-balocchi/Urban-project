## Aggregate crime data from the csv downloaded for the Philadelphia Police Department

In 'setup_crime.R', I create the aggregated datasets from the csv crime file, both aggregating over block groups and over tracts. The crime file was downloaded from https://www.opendataphilly.org/dataset/crime-incidents.
I consider the transformation Inverse Hyperbolic Sine transformation. 
I include years from 2006 to 2017. 
The functions to make those modifications are contained in 'clean_crime.R'.
This code requires that you have downloaded shapefiles of the regions you want to aggregate over and save them as R objects as done in 'import_shapefiles.R'. 
The shapefiles for Phiadelphia can be downloaded at
https://www.opendataphilly.org/dataset/census-block-groups,
https://www.opendataphilly.org/dataset/census-blocks and https://www.opendataphilly.org/dataset/census-tracts (I used the shapefiles from 2010).

Some of this code was created with the help of Colman Humphrey (https://github.com/ColmanHumphrey/). For other useful functions you can check 'setupcrime_colman.R'.

## Get shapefiles and import them in R

In 'import_shapefiles.R' we use `readOGR` (from the package 'rgdal') to read and import a shapefile into R. Remember that the folder containing your '.shp' file should also contain a bunch of other files with the same name but different extension (.shx, .prj, .dbf, .cpg).

## GEOID in Shapefiles

GEOID10 is an important identifier for blocks/block groups/census tracts shapefiles. 
In the shapefile Colman gave me originally this variable was missing, I just add it with 'get_GEOID.R'.

## Adding covariate and transformations for the linear model

In 'get_covariates_from_csv.R' I construct the covariates (poverty, income, population total and segregatio) from the CSV downloaded from the census, reorder them appropriately and merge them to our dataset.
In 'add_covariates.R' I use some transformations to our covariates and combine them with the crime data that I got from 'crime_setup' ('crime_agr2018.Rdata') to create the dataset that we will use for the data analysis.

For downloading the CSV files from the census, check covariates_readme.txt.
