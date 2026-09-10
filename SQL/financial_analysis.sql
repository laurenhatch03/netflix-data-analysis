use netflix;

-- 1. Revenue and profitability by year
-- Examines Netflix's total revenue, gross profit, operating income, and net income over time
select 
	year, 
	total_revenue,
	total_gross_profit, 
	total_operating_income, 
	total_net_income 
from financials
order by year;

-- 2. Year-over-Year Revenue Growth
-- Calculates Netflix's annual revenue growth percentage and compares each year with the previous year
select 
	year, 
	total_revenue, 
	lag(total_revenue) over (order by year) as previous_year_revenue, 
	round((total_revenue - lag(total_revenue) over (order by year))/lag(total_revenue) over (order by year) * 100, 2) as revenue_growth_pct
from financials
order by year;

-- 3. Gross Profit Margin by Year
-- Measures the percentage of revenue remaining after accounting for the cost of revenue
select 
	year, 
	round(((total_revenue - total_cost_of_revenue)/total_revenue)*100,2) as gross_margin 
from financials
order by year;

-- 4. Operating Profit Margin by Year
-- Measures Netflix's operating profitability as a percentage of total revenue
select 
	year, 
	round((total_operating_income /total_revenue)*100,2) as operating_margin 
from financials
order by year;

-- 5. Net Profit Margin by Year
-- Measures the percentage of revenue Netflix retains as net income after all expenses
select 
	year, 
	round((total_net_income/total_revenue)*100,2) as net_margin 
from financials
order by year;

-- 6. Operating Cash Flow vs. Capital Expenditures
-- Compares cash generated from operations with capital expenditures to evaluate Netflix's cash generation relative to investment spending
select 
	year, 
	operating_cash_flow,
	capex, 
	operating_cash_flow + capex as difference 
from financials
order by year;

-- 7. Best / Worst Financial Years
-- Ranks Netflix's financial years based on revenue growth and net profit margin to identify stronger and weaker overall performance
with financial_metrics as (
    select
        year,
        total_revenue,

        -- Year-over-year revenue growth
        round(
            (
                total_revenue
                - lag(total_revenue) over (order by year)
            )
            / nullif(
                lag(total_revenue) over (order by year),
                0
            ) * 100,
            2
        ) as revenue_growth_pct,

        -- Net profit margin
        round(
            total_net_income
            / nullif(total_revenue, 0) * 100,
            2
        ) as net_margin_pct

    from financials
),

ranked_years as (
    select
        year,
        total_revenue,
        revenue_growth_pct,
        net_margin_pct,

        -- Rank by highest revenue growth
        rank() over (
            order by revenue_growth_pct desc
        ) as growth_rank,

        -- Rank by highest net margin
        rank() over (
            order by net_margin_pct desc
        ) as margin_rank

    from financial_metrics

    -- 2015 has no prior year in the dataset,
    -- so it cannot have a revenue growth rate.
    where revenue_growth_pct is not null
)

select
    year,
    total_revenue,
    revenue_growth_pct,
    net_margin_pct,
    growth_rank,
    margin_rank,

    -- Lower combined rank = stronger overall performance
    growth_rank + margin_rank as performance_score

from ranked_years
order by performance_score, year;