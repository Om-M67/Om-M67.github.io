# Telecom Churn — SQL Queries

## Problem statement
Telecom companies lose significant revenue to customer churn. This project uses SQL
(MySQL/MariaDB) against a customer-level telecom dataset to identify which customer
segments churn most, and to demonstrate core SQL skills — joins, aggregation, subqueries,
and window functions — end to end.

## Dataset
`customers.csv` — 1,000 customer records with:

| Column | Description |
|---|---|
| customer_id | Unique customer identifier |
| region | North / South / East / West |
| tenure_months | Months as a customer (0–72) |
| contract_type | Month-to-month / One year / Two year |
| internet_type | DSL / Fiber optic / No |
| payment_method | Electronic check / Mailed check / Bank transfer / Credit card |
| monthly_charges | Monthly bill amount |
| total_charges | Total billed to date |
| churn | Yes / No |

## Key findings

- **Contract type is the strongest churn driver.** Month-to-month customers churn at
  **51.9%**, versus 19.6% for one-year and 16.7% for two-year contracts.
- **Fiber optic customers churn more than DSL customers across every region** (e.g. North:
  47.8% fiber vs 36.8% DSL), despite paying similar monthly rates — suggesting the issue is
  service/reliability perception rather than price.
- **All four regions are running above a 30% churn-rate target**, with North highest at 40.1%.
- High-paying customers are not immune to churn: several customers paying above the
  average monthly charge still churned, representing avoidable high-value losses.

## Queries included (`churn_queries.sql`)

1. Churn rate by contract type (aggregation)
2. Churn rate by region + internet type (multi-column GROUP BY)
3. Region churn rate vs. target, using a joined lookup table (JOIN)
4. Above-average-paying customers who churned (subquery)
5. Top 3 highest-value customers per region (window function — `RANK() OVER`)
6. Rolling average monthly charge by tenure (window function — moving average)

## Tools
MySQL / MariaDB, loaded from CSV via `LOAD DATA LOCAL INFILE`.

## How to reproduce
```sql
CREATE DATABASE telecom_churn;
USE telecom_churn;
-- create table (see churn_queries.sql header)
LOAD DATA LOCAL INFILE 'customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```
Then run `churn_queries.sql`.
