# Default Credit Risk analysis
## Project Background

## Executive Summary
This project analyzes credit card payment behavior using an anonymized dataset from the UCI Machine Learning Repository. The objective is to understand patterns in billing, payment activity, and delinquency in order to identify key indicators associated with default risk. I built a data pipeline using PostgreSQL, engineered features, and performed risk summarization that could inform credit risk decision-making.

## Business Questions

#### This project focuses on practical stakeholder-style questions such as:
1. What is the overall default rate in the dataset?

2. How does delinquency (late payment behavior) relate to default?

3. Do high utilization and low payment coverage correlate with higher default risk?

4.  Which engineered behavioral features are most useful for identifying risk?

5.  What behaviors are most associated with default?

6. How does delinquency relate to default?

7.  Does utilization signal risk?

### Objectives

1. Clean and normalize imported data

2. Convert Taiwan Dollar (TWD) values to USD

3. Engineer behavioral and utilization features

4. Explore associations with default risk

5. Deliver business-ready metrics and interpretations



## Dataset Overview
The dataset comes from Kaggle: “Default of Credit Card Clients”. It contains 30,000 anonymized credit card customer records with six months of billing and payment history, demographic attributes, and a default indicator. Features include monthly statement balances (`bill_amt1` - `bill_amt_6`), payment amounts (`pay_amt1`-`pay_amt6`), and repayment status (`pay_0`–`pay_6`), along with customer attributes like age, credit limit, education, and marriage status.

(https://archive.ics.uci.edu/dataset/350/default+of+credit+card+clients)

I. Yeh. "Default of Credit Card Clients,"
UCI Machine Learning Repository, 2009. 
[Online]. Available: (https://doi.org/10.24432/C55S3H.)
### Data Pipeline
To simulate a real analytics workflow, I used a multi-table approach:
1. `credit_raw` (Landing Table)   
    * Stores imported CSV data in a “raw” state.
    * Used for initial ingestion and data checks.
    * Goal: preserve original structure before transformations.
2) `credit_usd` (Cleaned + Currency Converted)
    * Converts TWD values to USD using a conversion rate:
    * 1 TWD = 0.032 USD
    * Standardizes column names
    * Ensures consistent numeric types for analysis
3) `credit_features` (Analytics / Feature Table)
    * Contains engineered features used for analysis and segmentation:
        * totals

        * averages
        * delinquency behavior
        * utilization proxy

### Data Cleaning Notes
#### During import and validation, several real-world data issues were handled:
* The dataset contained a hidden BOM character causing issues with integer casting.
* Header Row Imported as Data
* The CSV header row was included as a record during import, causing MIN() and MAX() checks to return unexpected results. This row was removed from analysis.
* Column Name Differences (PAY_0 vs PAY_1)
* The dataset uses PAY_0 (not PAY_1), which required alignment between schema and source CSV.
* BOM character in header resolved
* Filtered header row from data

* Ensured numeric conversion and type safety

 #### Staging & Core Table
 ##### Built a staging table with proper numeric types (`INTEGER`, `NUMERIC`) and base cleaned values.
 ![alt text](https://attachment:37d3ecf4-1d9b-4335-85a4-73323a5cc151.png "Logo Title Text 1")
 ![image.png](attachment:37d3ecf4-1d9b-4335-85a4-73323a5cc151.png)
 
### Tools & Technologies
 PostgreSQL (database + SQL analytics)

pgAdmin 4 (query execution + database management)

CSV dataset import

(Optional for visuals) Python / Excel / Tableau / Power BI
## Methodology
-------------------
* #### Data Exploration and Cleaning: Thorough scrutiny and cleaning of the data, including handling missing values and outliers.
* #### Feature Engineering: Creation and selection of features that improve analysis.
* #### Exploratory Data Analysis (EDA): In-depth visualization of data distributions, correlations, and other patterns.
* ### Deployment: Steps and methodologies for data preperation and analysis. 
-------------------
## Feature Engineering
| Feature                   | Description                              |
| ------------------------- | ---------------------------------------- |
| `limit_bal_usd`           | Credit limit in USD                      |
| `total_bill_amt_usd`      | Sum of six months of billing             |
| `total_pay_amt_usd`       | Sum of six months of payments            |
| `avg_monthly_balance_usd` | Average monthly balance                  |
| `avg_pay_amt_usd`         | Average payment per month                |
| `util_proxy_usd`          | Average balance relative to credit limit |
| `payment_coverage_ratio`  | Total paid vs total billed               |
| `worst_payment_status`    | Worst delinquency status over time       |
| `late_months_count`       | Count of months with late payments       |


## Analysis + Findings

### Analysis
default rate overall
default rate by worst delinquency
default rate by utilization bucket
##### paste charts here
* Customers with higher utilization ratios (>0.8) have significantly higher default rates compared to those below 0.5.
* A greater number of late months correlates with higher probabilities of default.
* Payment coverage ratio below 0.9 is associated with elevated risk.
* Worst payment status consistently predicts future delinquency.

  ### Other Findings
## Business Implications

These insights could be used by credit risk teams to prioritize interventions, flag accounts for closer monitoring, and improve early-warning systems. Key features like utilization and payment coverage can inform policy changes and risk scoring.

## Reccommendations
### Limitations

Example:

no true loss / recovery data

statement balances are snapshots, not charges

