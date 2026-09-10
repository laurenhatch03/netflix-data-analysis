use netflix;

-- 1. Verify table row counts

select 'financials' as table_name, count(*) as row_count from financials

union all

select 'engagement', count(*) from engagement

union all

select 'top10', count(*) from top10;


-- 2. Verify date/year ranges

select min(year) as first_year, max(year) as last_year from financials;
select min(year) as first_year, max(year) as last_year from engagement;
select min(week) as first_week, max(week) as last_week from top10;


-- 3. check for duplicate financial years
select year, count(*) as row_count from financials
group by year
having count(*) >1;

-- 4. missing key fields
select count(*) as missing_title_names from engagement
where title_name is null or trim(title_name) = '';

select count(*) as missing_top10_titles from top10
where show_title is null or trim(show_title) ='';

-- 5. engagement metric availability
select count(*) as total_rows,
sum(hours_viewed is not null) as rows_with_hours,
sum(views is not null) as rows_with_views,
sum(hours_viewed is null and views is null) as rows_with_neither
from engagement;

-- 6. check top 10 categories
select category, count(*) as row_count from top10
group by category
order by row_count desc;