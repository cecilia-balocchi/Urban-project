## Aggregate crime data from the csv downloaded for the Philadelphia Police Department

In 'setup_crime.R', I create the aggregated datasets from the csv crime file, both aggregating over block groups and over tracts. 
I consider the new transformation Inverse Hyperbolic Sine transformation. 
I include years from 2006 to 2017. 
The functions to make those modifications are contained in 'clean_crime.R'.

Some of this code was created with the help of Colman. For other useful functions check 
'setupcrime_colman.R'.

## Adding covariate and transformations for the linear model

In 'get order in poverty and income13.R' I reconstruct the poverty and income metrics and convert them to the right order relative to our dataset.
In 'add_covariates.R' I use some transformations to create the dataset that we will use for the data analysis.

## GEOID in Shapefiles

GEOID10 is an important identifier for blocks/block groups/census tracts shapefiles. 
In the shapefile Colman gave me originally this variable was missing, I just add it with 'get_GEOID.R'.

### Some notes
- Use `readOGR` (instead of 'readShapePoly') to read and import a shapefile into R. Set the working directory where all the files are (not only .shp but also .shx, .prj, .dbf, .cpg). Use: 'readOGR("path/to/file.shp")'.
- I usually import my shapefiles and save them as R objects in 'data/shapefiles'.
- In `create data for sameer.R' I created a dataset with the number of crimes divided by type.
