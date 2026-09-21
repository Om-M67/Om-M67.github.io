-- =====================================================================
-- Telecom Churn Analysis — SQL Queries
-- Dataset: customers table (1000 rows, synthetic telecom churn data)
-- =====================================================================

-- 1. Basic aggregation: churn rate by contract type
SELECT
    contract_type,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate_pct
FROM customers
GROUP BY contract_type
ORDER BY churn_rate_pct DESC;

-- 2. Churn rate by region and internet type (multi-column GROUP BY)
SELECT
    region,
    internet_type,
    COUNT(*) AS total_customers,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_rate_pct,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
FROM customers
GROUP BY region, internet_type
ORDER BY churn_rate_pct DESC;

-- 3. "Join" query: create a region_targets lookup table and join against it
--    to flag which regions are above/below a churn-rate target
DROP TABLE IF EXISTS region_targets;
CREATE TABLE region_targets (
    region VARCHAR(20) PRIMARY KEY,
    target_churn_rate DECIMAL(5,2)
);
INSERT INTO region_targets (region, target_churn_rate) VALUES
    ('North', 30.00), ('South', 30.00), ('East', 30.00), ('West', 30.00);

SELECT
    c.region,
    ROUND(100.0 * SUM(CASE WHEN c.churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS actual_churn_rate,
    rt.target_churn_rate,
    CASE
        WHEN 100.0 * SUM(CASE WHEN c.churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) > rt.target_churn_rate
        THEN 'Above target'
        ELSE 'On/below target'
    END AS status
FROM customers c
JOIN region_targets rt ON c.region = rt.region
GROUP BY c.region, rt.target_churn_rate
ORDER BY actual_churn_rate DESC;

-- 4. Subquery: customers paying above the overall average monthly charge who churned
SELECT
    customer_id,
    region,
    contract_type,
    monthly_charges,
    churn
FROM customers
WHERE monthly_charges > (SELECT AVG(monthly_charges) FROM customers)
  AND churn = 'Yes'
ORDER BY monthly_charges DESC
LIMIT 10;

-- 5. Window function: rank customers by total_charges within each region
--    (useful for identifying top-value customers per region, e.g. for retention outreach)
SELECT * FROM (
    SELECT
        customer_id, region, total_charges, churn,
        RANK() OVER (PARTITION BY region ORDER BY total_charges DESC) AS value_rank_in_region
    FROM customers
) ranked
WHERE value_rank_in_region <= 3;

-- 6. Window function #2: running average of monthly charges by tenure
--    (shows whether newer or longer-tenured customers pay more, ordered along tenure)
SELECT
    tenure_months,
    monthly_charges,
    ROUND(AVG(monthly_charges) OVER (ORDER BY tenure_months
        ROWS BETWEEN 20 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_monthly_charge
FROM customers
ORDER BY tenure_months
LIMIT 15;
