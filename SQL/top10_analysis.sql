use netflix;

-- 1. Most Weeks in the Global Top 10
-- Shows which titles had the longest sustained popularity
select
    show_title,
    category,
    max(cumulative_weeks_in_top_10) as weeks_in_top_10
from top10
group by show_title, category
order by weeks_in_top_10 desc
limit 10;


-- 2. Titles with the Most Total Hours Viewed
-- Measures total viewing hours accumulated while titles appeared in the Global Top 10
select
    show_title,
    category,
    sum(weekly_hours_viewed) as total_hours_viewed
from top10
group by show_title, category
order by total_hours_viewed DESC
limit 10;


-- 3. Titles with the Most Total Views
-- Identifies the titles that generated the highest number of weekly views across their Top 10 appearances
select
    show_title,
    category,
    sum(weekly_views) as total_views
from top10
group by show_title, category
order by total_views desc
limit 10;


-- 4. Average Weekly Rank
-- A lower average rank indicates stronger performance
select
    show_title,
    category,
    round(avg(weekly_rank), 2) as average_weekly_rank,
    count(*) as weeks_in_top_10
from top10
group by show_title, category
having COUNT(*) >= 3
order by average_weekly_rank asc
limit 10;


-- 5. Number of #1 Rankings
-- Identifies titles that reached the top position most often
select
    show_title,
    category,
    count(*) as number_one_weeks
from top10
where weekly_rank = 1
group by show_title, category
order by number_one_weeks desc
limit 10;


-- 6. Movies vs TV Shows in the Global Top 10
-- Compares overall performance between content categories
select
    category,
    count(distinct show_title) as unique_titles,
    sum(weekly_hours_viewed) as total_hours_viewed,
    sum(weekly_views) as total_views,
    round(avg(weekly_rank), 2) as average_weekly_rank
from top10
group by category
order by total_hours_viewed desc;


-- 7. Top 10 Performance by Year
-- Shows how Global Top 10 viewing changed over time
select
    year,
    count(distinct show_title) as unique_titles,
    sum(weekly_hours_viewed) as total_hours_viewed,
    sum(weekly_views) as total_views
from top10
group by year
order by year;


-- 8. Titles with the Highest Average Weekly Views
-- Helps identify titles that consistently generated strong weekly audience engagement
select
    show_title,
    category,
    round(avg(weekly_views), 0) as avg_weekly_views,
    count(*) AS weeks_in_top_10
from top10
where weekly_views is not null
group by show_title, category
having COUNT(*) >= 3
order by avg_weekly_views desc
limit 10;


-- 9. Titles with the Highest Average Weekly Hours Viewed
-- Measures the typical weekly viewing demand for each title
select
    show_title,
    category,
    round(avg(weekly_hours_viewed), 0) as avg_weekly_hours_viewed,
    count(*) as weeks_in_top_10
from top10
where weekly_hours_viewed is not null
group by show_title, category
having COUNT(*) >= 3
ORDER BY avg_weekly_hours_viewed desc
limit 10;


-- 10. Most Successful Titles Overall
-- Combines sustained Top 10 presence with viewing hours to identify consistently successful titles
with title_performance as (
    select
        show_title,
        category,
        max(cumulative_weeks_in_top_10) as weeks_in_top_10,
        sum(weekly_hours_viewed) as total_hours_viewed,
        round(avg(weekly_rank), 2) as average_weekly_rank
    from top10
    group by show_title, category
)

select
    show_title,
    category,
    weeks_in_top_10,
    total_hours_viewed,
    average_weekly_rank,

    -- Lower rank = better performance
    rank() over (
        order by
            total_hours_viewed desc
    ) as viewing_rank

from title_performance
order by viewing_rank
limit 10;

