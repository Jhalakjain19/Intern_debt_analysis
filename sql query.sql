-- creating database

create database debt

-- selecting database

use debt

-- creating table

CREATE TABLE international_debt (
    country_name VARCHAR(50),
    country_code VARCHAR(50),
    indicator_name TEXT,
    indicator_code TEXT,
    debt NUMERIC
);


-- uploading data into mysql

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\cleaned_dataset.csv'
INTO TABLE international_debt
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


-- 1) The World Bank's international debt data

select * 
from international_debt

-- 2) Finding the number of distinct countries

select count(distinct country_name) as total_countries
from international_debt
-- 3) Finding out the distinct debt indicators

select distinct(indicator_code) 
from international_debt

-- 4) Totaling the amount of debt owed by the countries

select distinct(country_name) as country_name, SUM(debt) as debt
from international_debt
group by country_name

-- 5) Country with the highest debt

select distinct(country_name) as country_name, SUM(debt) as debt
from international_debt
group by country_name
order by debt desc
limit 1

-- 6) Average amount of debt across indicators

select indicator_code, avg(debt) as average_debt
from international_debt

-- 7) The highest amount of principal repayments

select max(debt) as highest_repayment, indicator_name
from international_debt

-- 8) The most common debt indicator

select indicator_code, count(*) as common_indicator
from international_debt
group by indicator_name
order by common_indicator desc
limit 1

-- 9) Other viable debt issues and conclusion

select country_name, indicator_code, max(debt) as maximum_debt
from international_debt
group by country_name, indicator_code
order by max(debt) desc
limit 5