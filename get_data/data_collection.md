# Data collection [Philadelphia]

Here are some instructions on how to collect covariates data.

## Poverty from the American Community Survey

On [https://factfinder.census.gov](https://factfinder.census.gov/) select 'Advanced Search'.

Under Geographies select
Geographic type: 'Block Group - 150'
State: 'Pennsylvania'
County: 'Philadelphia'
and 'All Block Groups within Philadelphia County, Pennsylvania'
and add that to your selection.

Under Topics select 'People' > 'Poverty' > 'Poverty'.

Under year 2013 select and download the dataset 'RATIO OF INCOME TO POVERTY LEVEL IN THE PAST 12 MONTHS', with ID C17002.

## Income from the American Community Survey

About income measures: [https://www.investopedia.com/terms/h/household_income.asp](https://www.investopedia.com/terms/h/household_income.asp)

> Economists use household income to draw a host of conclusions about the economic health of a given area or population. For example, comparing median household incomes across various countries provides a glimpse as to where citizens enjoy the highest quality of life.

Moreover:

> Household income considers the incomes of all people ages 15 years or older occupying the same housing unit, regardless of relation. A single person occupying a dwelling by himself is also considered a household. Family income, by contrast, considers only households occupied by two or more people related by birth, marriage or adoption. Per capita income measures the average income earned by each person in a given area.

Thus we want to use Median Household income.

On [https://factfinder.census.gov](https://factfinder.census.gov/) select 'Advanced Search'.

Under Geographies select
Geographic type: 'Block Group - 150'
State: 'Pennsylvania'
County: 'Philadelphia'
and 'All Block Groups within Philadelphia County, Pennsylvania'
and add that to your selection.

Under Topics select 'People' > 'Income & Earnings (Households)' > 'Income/Earnings (Households)'.

Under year 2013 select and download the dataset ~~'MEDIAN HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2013 INFLATION-ADJUSTED DOLLARS)', with ID B19013.~~

'PER CAPITA INCOME IN THE PAST 12 MONTHS (IN 2013 INFLATION-ADJUSTED DOLLARS)' with ID B19301.

## Population total from the American Community Survey

*No need to do this because we automatically get population from the next one.*

On [https://factfinder.census.gov](https://factfinder.census.gov/) select 'Advanced Search'.

Under Geographies select
Geographic type: 'Block Group - 150'
State: 'Pennsylvania'
County: 'Philadelphia'
and 'All Block Groups within Philadelphia County, Pennsylvania'
and add that to your selection.

Under Topics select 'People' > 'Basic Count/Estimate' > 'Population Total'.

Under year 2010 select and download the dataset 'TOTAL POPULATION', with ID P1.

## Population total and race from the American Community Survey

On [https://factfinder.census.gov](https://factfinder.census.gov/) select 'Advanced Search'.

Under Geographies select
Geographic type: 'Block Group - 150'
State: 'Pennsylvania'
County: 'Philadelphia'
and 'All Block Groups within Philadelphia County, Pennsylvania'
and add that to your selection.

Under Topics select 'People' > 'Basic Count/Estimate' > 'Population Total'.

Under Topics select 'People' > 'Origins' > 'Hispanic or Latino'.

Under year 2010 select and download the dataset 'HISPANIC OR LATINO ORIGIN BY RACE', with ID P5.

For other covariates, check Colman's 

[ColmanHumphrey/urbananalytics](https://github.com/ColmanHumphrey/urbananalytics/blob/master/code/get_clean_data/setup_main.R)
start from "## landuse"; the functions called are here: [https://github.com/ColmanHumphrey/urbananalytics/blob/master/code/get_clean_data/subsetup/setup_landuse.R](https://github.com/ColmanHumphrey/urbananalytics/blob/master/code/get_clean_data/subsetup/setup_landuse.R)