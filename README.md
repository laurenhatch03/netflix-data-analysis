
# Netflix Data Analysis

**Project Timeline:** August 16, 2026 – September 10, 2026  
**Status:** Completed

## Project Overview
The purpose of this project is to analyze Netflix’s financial performance, viewer engagement, and content performance to develop a better understanding of the company and its trends. Data was first collected and compiled from multiple sources, which are documented below. The data was then cleaned and prepared using Python and pandas. Next, Power BI was used to create interactive dashboards and visualize key trends within each dataset. SQL was then used to further explore and analyze the data. Observations, decisions, and conclusions made throughout the project are documented along the way.

## Tools Used
- Excel
- Python (Pandas)
- SQL
- Power BI

## Data Collection & Sources

The Excel files used for data cleaning can be found here:

- [Final Cleaned Tables](data/Netflix_Analysis_Data.xlsx)
- [Raw Data](data/Netflix_Raw_Data.xlsx)

### Financial Data
Financial data from 2015–2025 was obtained from [Netflix's SEC Filings](https://ir.netflix.net/financials/sec-filings/default.aspx). Netflix's annual 10-K and quarterly 10-Q filings were used to collect the financial data. Some financial fields were no longer reported in later years; where possible, missing values were calculated using other reported figures. Values that could not be reliably calculated were left blank.

The [cleaned excel file](data/Netflix_Analysis_Data.xlsx) contains the financial dataset along with column descriptions, a color key, example screenshots of the source data, and the equations used for calculated values.

### Engagement Data
Engagement data from 2023–2025 was obtained from the [What's on Netflix Engagement Report Search](https://www.whats-on-netflix.com/most-popular/netflix-engagement-report-search/). Half-year reporting periods were used to make changes in engagement over time easier to compare and visualize.

The raw data was cleaned and prepared in Python using pandas. The Python cleaning notebook is included in this repository. Both the raw and cleaned data are available in the [data folder](data), along with column descriptions, calculations used to create additional fields, and a title reference table for the final combined engagement dataset.

### Top 10 Data
Weekly global Top 10 data was obtained directly from [Netflix's Top 10 dataset](https://www.netflix.com/tudum/top10/data/all-weeks-global.xlsx). The raw dataset was cleaned and prepared in Python using pandas, and the cleaning notebook is included in this repository.

Both the original raw data and the final cleaned dataset are available in the [data folder](data). Column descriptions for the final dataset are also included for reference.

## Data Cleaning & Preparation
After the data was collected, the raw data was imported into Python for cleaning and preparation. Since the financial dataset was manually collected and organized, it did not require additional cleaning in Python.

The Python notebooks used for data cleaning can be found here:

- [Engagement Data Cleaning Notebook](notebooks/Engagement_data_cleaning.ipynb)
- [Top 10 Data Cleaning Notebook](notebooks/Top10_data_cleaning.ipynb)

### Engagement Data
The engagement data originally consisted of two separate datasets: one reporting hours viewed and another reporting number of views. Both datasets went through the same general cleaning process.

First, the data was reshaped into a more analysis-friendly format, with the reporting period and half-year represented as rows rather than separate columns. Runtime values were then converted from a DD/HH/MM format into total minutes to make them easier to use in calculations and visualizations. Unnecessary characters, such as hyphens used in place of values, were also removed or replaced so the fields could be interpreted correctly by analytical tools.

Title names were then cleaned and standardized. Some titles had been unintentionally translated or altered due to their original data type and formatting, so these values were corrected to maintain consistency between the datasets.

After cleaning the Hours Viewed and Views datasets separately, they were combined to create the final Engagement dataset used for analysis. Both the intermediate cleaned datasets and the final combined dataset are included in the Excel workbook.

### Top 10 Data
The Top 10 dataset required less cleaning because the original data was already well structured. Since this project focuses on 2022–2025, records from 2026 were removed. Data types were also reviewed and adjusted where necessary to ensure the fields could be analyzed correctly.


## Power BI Dashboards
Power BI was used to create three interactive dashboard pages focused on Netflix's financial performance, viewer engagement, and weekly Top 10 performance.

### Financial Performance Dashboard

![Netflix Financial Dashboard](images/financial_dashboard.png)

Provides an overview of Netflix's financial performance from 2015–2025, including revenue, profitability, cash flow, assets, liabilities, and content assets. The dashboard includes interactive year filtering to explore changes over time.

### Engagement Dashboard

![Netflix Engagement Dashboard](images/engagement_dashboard.png)

Explores Netflix's viewer engagement from 2023–2025, including hours viewed, views, content type, and title-level performance. Interactive filters allow engagement trends to be compared across reporting periods and content types.

### Top 10 Dashboard

![Netflix Top 10 Dashboard](images/top10_dashboard.png)

Analyzes Netflix's weekly global Top 10 performance from 2022–2025, including rankings, weekly viewing activity, category performance, and the titles with the longest Top 10 presence.

### Power BI File

All three dashboard pages are contained in a single Power BI report.
[View the Power BI report](dashboards/Netflix_Dashboards.pbix).

## SQL Analysis

SQL was used to further analyze the cleaned Netflix datasets and identify trends across financial performance, viewer engagement, and Top 10 content performance.

### [Financial Analysis](SQL/financial_analysis.sql) 

* Calculated year-over-year revenue growth from 2015–2025
* Analyzed gross, operating, and net profit margins
* Compared operating cash flow with capital expenditures
* Examined long-term changes in revenue, profitability, cash flow, assets, and liabilities

### [Engagement Analysis](SQL/engagement_analysis.sql) 

* Ranked titles by total hours viewed and total views
* Compared engagement across Movies and TV Shows
* Analyzed average engagement by reporting period
* Identified titles with the highest overall viewer engagement
* Compared reported views with calculated views where applicable

### [Top 10 Analysis](SQL/top10_analysis.sql) 

* Identified titles with the most cumulative weeks in the Global Top 10
* Ranked titles by total weekly hours viewed
* Ranked titles by total weekly views
* Analyzed average weekly ranking
* Counted the number of #1 rankings achieved by each title
* Compared Movies and TV Shows within the Global Top 10
* Analyzed Top 10 performance by year
* Identified titles with the highest average weekly viewing activity

### SQL Techniques Used

The analysis used:

* `SELECT`, `WHERE`, `GROUP BY`, and `ORDER BY`
* Aggregate functions such as `SUM()`, `AVG()`, `MAX()`, and `COUNT()`
* `HAVING` for filtering aggregated results
* `CASE` statements for categorization
* Common Table Expressions (CTEs)
* Window functions such as `RANK()`
* Joins and calculated fields

The SQL analysis helped turn the cleaned datasets into specific, measurable business insights and provided another way to validate findings from the Python and Power BI analysis.


## Key Findings

The analysis shows a Netflix business that has expanded significantly over the past decade while becoming increasingly profitable and leveraging a relatively small group of highly successful titles to drive substantial viewer engagement.

### Financial Performance

* **Netflix experienced substantial long-term revenue growth.** Annual revenue increased from approximately **$6.8 billion in 2015 to $45.2 billion in 2025**, representing more than a sixfold increase over the period.
* **Profitability improved alongside revenue growth.** Operating income increased from approximately **$306 million in 2015 to $13.3 billion in 2025**, while net income increased from approximately **$123 million to $11.0 billion**.
* **Margins have expanded considerably.** Netflix's operating margin reached **29.5% in 2025**, compared with 17.8% in 2022 and 20.6% in 2023. This indicates that recent growth has translated into stronger operating leverage rather than simply higher revenue.
* The SQL analysis reinforced this trend by comparing **year-over-year revenue growth, gross margin, operating margin, net margin, and cash flow against capital expenditures** to evaluate not only growth but the quality of that growth.

### Viewer Engagement

* The engagement analysis covering **2023–2025** shows that Netflix's viewing activity is highly concentrated around a relatively small number of successful titles. The underlying engagement dataset combines both **hours viewed and views** and was transformed into consistent half-year reporting periods for comparison.
* **TV content can generate substantial cumulative viewing hours because of its longer runtimes and episodic structure**, while movies can generate very large numbers of individual views. Comparing both metrics provides a more complete picture of content performance than relying on either metric alone.
* The Python cleaning process was important to making these comparisons possible. Runtime values were converted into minutes, reporting periods were reshaped into rows, title names were standardized, and the separate Hours Viewed and Views datasets were combined into a single analysis-ready engagement dataset.
* The analysis also demonstrates why **views and hours viewed should not be treated as interchangeable metrics**: a title can generate a high number of views without necessarily producing the highest number of total viewing hours.

### Top 10 Content Performance

* Netflix's Top 10 data shows that **short-term popularity and sustained popularity are different measures of success**. Weekly rank and weekly viewing activity identify titles that create immediate demand, while cumulative weeks in the Top 10 reveal titles with longer-lasting audience interest.
* **KPop Demon Hunters** is a strong example of sustained performance. By the end of 2025, it had accumulated **28 weeks in the Global Top 10**, substantially longer than many titles appearing in the weekly rankings.
* The Top 10 dataset also demonstrates the importance of analyzing **category and language separately**. Netflix's weekly rankings distinguish between categories such as English films and non-English TV, allowing content performance to be evaluated within its appropriate competitive group.
* SQL analysis expands on the Power BI visualizations by ranking titles according to **total viewing hours, total views, average weekly rank, number of #1 rankings, and weeks spent in the Top 10**. This provides multiple definitions of "success" rather than relying on a single ranking.

### Overall Business Takeaway

Taken together, the analysis suggests that Netflix's growth is supported by **two complementary strengths: improving financial efficiency and strong content engagement**. Financial results show substantial revenue growth accompanied by expanding profitability, while the engagement and Top 10 analyses show that individual titles can generate significant and sustained audience demand.

The analysis also highlights an important distinction between **volume and quality of performance**. Revenue growth alone does not explain Netflix's improving financial position, just as appearing in the Top 10 once does not necessarily indicate sustained content success. Looking across financial metrics, viewing behavior, weekly rankings, and title-level performance provides a more complete picture of Netflix's business.

### Analytical Approach

This project used multiple tools to approach the same business questions from different perspectives:

* **Excel** — data collection, organization, documentation, calculations, and preparation
* **Python** — data cleaning, reshaping, standardization, and dataset preparation
* **Power BI** — interactive dashboards for financial performance, engagement, and Top 10 trends
* **SQL** — deeper analysis using aggregations, window functions, CTEs, rankings, growth calculations, and profitability metrics

The combination of these tools created an end-to-end workflow from **raw data → cleaned datasets → exploratory analysis → interactive visualization → deeper SQL analysis → business insights**.


