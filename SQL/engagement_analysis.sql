use netflix;

-- 1. Total Hours Viewed by Year and Reporting Period 
-- Measures total hours viewed across Netflix content for each half-year reporting period
select 
	year, 
	period, 
	sum(hours_viewed) as total_hours_viewed 
from engagement
group by year, period
order by total_hours_viewed desc;

-- 2. Total Views by Year and Reporting Period
-- Compares total content views across each half-year reporting period 
select 
	year, 
	period, 
	sum(views) as total_views 
from engagement
group by year, period
order by total_views desc;

-- 3. Top Titles by Total Hours Viewed
-- Identifies the titles that generated the highest total viewing hours across the engagement data
select 
	title_name, 
	sum(hours_viewed) as total_hours_viewed, 
	sum(views) as total_views 
from engagement
group by title_name
order by total_hours_viewed desc;

-- 4. Top Titles by Total Views
-- Identifies the titles with the highest total number of views and compares their total viewing hours
select 
	title_name, 
	sum(views) as total_views, 
	sum(hours_viewed) as total_hours_viewed 
from engagement
group by title_name
order by total_views desc;

-- 5. Movies vs. TV Shows
-- Compares engagement and average runtime between Movies and TV Shows
select 
	type,
	sum(hours_viewed), 
	sum(views),
	avg(runtime_minutes) 
from engagement
group by type;

-- 6. Engagement by Half-Year
-- Compares overall viewing hours and views between the first and second halves of each year
select 
	half, 
	sum(hours_viewed),
	sum(views) 
from engagement
group by half;

-- 7. Engagement by Year
-- Analyzes how total viewing hours and views changed from year to year
select 
	year, 
	sum(hours_viewed), 
	sum(views) 
from engagement
group by year;
