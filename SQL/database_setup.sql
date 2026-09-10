

-- Update the three LOCAL INFILE paths below to match the location
-- of your CSV files on your computer before running this script.
-- MySQL Workbench must have LOCAL INFILE enabled for the imports.

create database if not exists netflix;
use netflix;


-- 1. Financials
drop table if exists financials;

create table financials (
    year text,
    q1_revenue text,
    q2_revenue text,
    q3_revenue text,
    q4_revenue text,
    total_revenue text,
    q1_cost_of_revenue text,
    q2_cost_of_revenue text,
    q3_cost_of_revenue text,
    q4_cost_of_revenue text,
    total_cost_of_revenue text,
    q1_gross_profit text,
    q2_gross_profit text,
    q3_gross_profit text,
    q4_gross_profit text,
    total_gross_profit text,
    total_operating_income text,
    q1_net_income text,
    q2_net_income text,
    q3_net_income text,
    q4_net_income text,
    total_net_income text,
    end_of_year_cash text,
    total_assets text,
    total_liabilities text,
    equity text,
    current_content_assets text,
    noncurrent_content_assets text,
    total_content_assets text,
    operating_cash_flow text,
    capex text
);

load data local infile '/path/to/financials.csv'
into table financials
character set latin1
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table financials
    modify column year int,
    modify column q1_revenue int,
    modify column q2_revenue int,
    modify column q3_revenue int,
    modify column q4_revenue int,
    modify column total_revenue int,
    modify column q1_cost_of_revenue int,
    modify column q2_cost_of_revenue int,
    modify column q3_cost_of_revenue int,
    modify column q4_cost_of_revenue int,
    modify column total_cost_of_revenue int,
    modify column q1_gross_profit int,
    modify column q2_gross_profit int,
    modify column q3_gross_profit int,
    modify column q4_gross_profit int,
    modify column total_gross_profit int,
    modify column total_operating_income int,
    modify column q1_net_income int,
    modify column q2_net_income int,
    modify column q3_net_income int,
    modify column q4_net_income int,
    modify column total_net_income int,
    modify column end_of_year_cash int,
    modify column total_assets int,
    modify column total_liabilities int,
    modify column equity int,
    modify column current_content_assets int null,
    modify column noncurrent_content_assets int null,
    modify column total_content_assets int,
    modify column operating_cash_flow int,
    modify column capex int;

alter table financials
    add primary key (year);


-- 2. Engagement
drop table if exists engagement;

create table engagement (
    title_id int,
    title_name varchar(255),
    type varchar(20),
    runtime_minutes int,
    period varchar(20),
    year int,
    half varchar(5),
    hours_viewed bigint null,
    views bigint null,
    calculated_views decimal(15,3) null,
    engagement_reported boolean
) character set utf8mb4 collate utf8mb4_unicode_ci;

load data local infile '/path/to/engagement.csv'
into table engagement
character set utf8mb4
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(
    title_id,
    title_name,
    type,
    runtime_minutes,
    period,
    year,
    half,
    @hours_viewed,
    @views,
    @calculated_views,
    engagement_reported
)
SET
    hours_viewed = nullif(REPLACE(@hours_viewed, ',', ''), ''),
    views = nullif(replace(@views, ',', ''), ''),
    calculated_views = nullif(@calculated_views, '');


-- 3. Global Top 10
drop table if exists top10;

create table top10 (
    week date,
    category varchar(50),
    weekly_rank int,
    show_title varchar(255),
    season_title varchar(255) null,
    weekly_hours_viewed bigint null,
    runtime decimal(10,2) null,
    weekly_views bigint null,
    cumulative_weeks_in_top_10 int,
    year int,
    month int
) character set utf8mb4 collate utf8mb4_unicode_ci;

load data local infile '/path/to/top10.csv'
into table top10
character set latin1
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(
    @week,
    category,
    weekly_rank,
    show_title,
    @season_title,
    @weekly_hours_viewed,
    @runtime,
    @weekly_views,
    cumulative_weeks_in_top_10,
    year,
    month
)
SET
    week = str_to_date(@week, '%m/%d/%y'),
    season_title = nullif(@season_title, ''),
    weekly_hours_viewed = nullif(replace(@weekly_hours_viewed, ',', ''), ''),
    runtime = nullif(@runtime, ''),
    weekly_views = nullif(replace(@weekly_views, ',', ''), '');