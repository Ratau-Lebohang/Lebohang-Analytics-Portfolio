-- MTN Nigeria Customer Churn EDA

SELECT *
FROM mtn_customer_churn;

-- 1. What is the overall customer churn rate for Q1 2025?
SELECT 
  ROUND(SUM(`Customer Churn`) / COUNT(*) * 100, 2) AS churn_rate_percentage
FROM 
  mtn_customer_churn;


-- 2. What is the total estimated revenue loss from churn?
SELECT 
  SUM(`Total Revenue`) AS total_revenue_lost
FROM 
  mtn_customer_churn
WHERE 
  `Customer Churn` = 1;

-- 3. What are the top 3–5 most frequent reasons for churn?
SELECT 
  `Reasons for Churn`, 
  COUNT(*) AS frequency
FROM 
  mtn_customer_churn
WHERE 
  `Customer Churn` = 1
GROUP BY 
  `Reasons for Churn`
ORDER BY 
  frequency DESC
LIMIT 5;

-- 4. Which device types show the highest vs lowest churn rates?
SELECT 
  `MTN Device`,
  ROUND(SUM(`Customer Churn`) / COUNT(*) * 100, 2) AS churn_rate
FROM 
  mtn_customer_churn
GROUP BY 
  `MTN Device`
ORDER BY 
  churn_rate DESC;

-- 5. How does satisfaction level (rate & review) correlate with churn?
SELECT 
  `Satisfaction Rate`,
  ROUND(SUM(`Customer Churn`) / COUNT(*) * 100, 2) AS churn_rate
FROM 
  mtn_customer_churn
GROUP BY 
  `Satisfaction Rate`
ORDER BY 
  `Satisfaction Rate`;

-- Customer Review vs Churn
SELECT 
  `Customer Review`,
  ROUND(SUM(`Customer Churn`) / COUNT(*) * 100, 2) AS churn_rate
FROM 
  mtn_customer_churn
GROUP BY 
  `Customer Review`
ORDER BY 
  churn_rate DESC;

-- 6. Are certain age groups or genders more prone to churn?
-- Age groups: <25, 25–34, 35–44, 45+
SELECT
  CASE 
    WHEN Age < 25 THEN '<25'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    ELSE '45+'
  END AS age_group,
  Gender,
  ROUND(SUM(`Customer Churn`) / COUNT(*) * 100, 2) AS churn_rate
FROM 
  mtn_customer_churn
GROUP BY 
  age_group, Gender
ORDER BY 
  age_group;

-- 7. At what tenure durations is churn most likely to occur?
-- Grouped in buckets: <6, 6–12, 13–24, 25+
SELECT 
  CASE 
    WHEN `Customer Tenure in months` < 6 THEN '<6 months'
    WHEN `Customer Tenure in months` BETWEEN 6 AND 12 THEN '6-12 months'
    WHEN `Customer Tenure in months` BETWEEN 13 AND 24 THEN '13-24 months'
    ELSE '25+ months'
  END AS tenure_group,
  ROUND(SUM(`Customer Churn`) / COUNT(*) * 100, 2) AS churn_rate
FROM 
  mtn_customer_churn
GROUP BY 
  tenure_group
ORDER BY 
  churn_rate DESC;

-- 8. Which subscription plans exhibit the highest churn and retention?
SELECT 
  `Subscription Plan`,
  COUNT(*) AS total_customers,
  SUM(`Customer Churn`) AS churned_customers,
  ROUND(SUM(`Customer Churn`) / COUNT(*) * 100, 2) AS churn_rate
FROM 
  mtn_customer_churn
GROUP BY 
  `Subscription Plan`
ORDER BY 
  churn_rate DESC;

-- 9. How does churn impact total revenue? Are high-value customers more likely to churn?
-- Segment by revenue tiers
SELECT 
  CASE 
    WHEN `Total Revenue` < 1000 THEN 'Low (1K)'
    WHEN `Total Revenue` BETWEEN 1000 AND 5000 THEN 'Mid (1K–5K)'
    ELSE 'High (5K)'
  END AS revenue_segment,
  COUNT(*) AS total_customers,
  SUM(`Customer Churn`) AS churned_customers,
  ROUND(SUM(`Customer Churn`) / COUNT(*) * 100, 2) AS churn_rate
FROM 
  mtn_customer_churn
GROUP BY 
  revenue_segment
ORDER BY 
  churn_rate DESC;


