# Data collection [Philadelphia]

Here are some instructions on how to collect covariates data.

## Poverty from the American Community Survey

On [https://factfinder.census.gov](https://factfinder.census.gov/) select 'Advanced Search'.

Under Geographies select
- Geographic type: 'Block Group - 150'
- State: 'Pennsylvania'
- County: 'Philadelphia'
- and 'All Block Groups within Philadelphia County, Pennsylvania'
and add that to your selection.

Under Topics select 'People' > 'Poverty' > 'Poverty'.

Under year 2013 select and download the dataset 'RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS', with ID C17002.

## Income from the American Community Survey

On [https://factfinder.census.gov](https://factfinder.census.gov/) select 'Advanced Search'.

Under Geographies select
- Geographic type: 'Block Group - 150'
- State: 'Pennsylvania'
- County: 'Philadelphia'
- and 'All Block Groups within Philadelphia County, Pennsylvania'
and add that to your selection.

Under Topics select 'People' > 'Income & Earnings (Households)' > 'Income/Earnings (Households)'.

Under year 2013 select and download the dataset 'PER CAPITA INCOME IN THE PAST 12 MONTHS (IN 2013 INFLATION-ADJUSTED DOLLARS)' with ID B19301.

## Population total and race from the American Community Survey

On [https://factfinder.census.gov](https://factfinder.census.gov/) select 'Advanced Search'.

Under Geographies select
- Geographic type: 'Block Group - 150'
- State: 'Pennsylvania'
- County: 'Philadelphia'
- and 'All Block Groups within Philadelphia County, Pennsylvania'
and add that to your selection.

Under Topics select 'People' > 'Basic Count/Estimate' > 'Population Total'.
Under Topics select 'People' > 'Origins' > 'Hispanic or Latino'.

Under year 2010 select and download the dataset 'HISPANIC OR LATINO ORIGIN BY RACE', with ID P5.

## Land use (comresprop and vacantprop)

For other covariates, check Colman's [ColmanHumphrey/urbananalytics](https://github.com/ColmanHumphrey/urbananalytics/blob/master/code/get_clean_data/setup_main.R)
start from "## landuse"; the functions called are here: [https://github.com/ColmanHumphrey/urbananalytics/blob/master/code/get_clean_data/subsetup/setup_landuse.R](https://github.com/ColmanHumphrey/urbananalytics/blob/master/code/get_clean_data/subsetup/setup_landuse.R)