-- Insurance Penetration and Growth Potential Analysis
use phonepe_pulse;

select * from aggregated_insurance;

-- use case 1 Insurance Penetration by State
-- Business Objective: To identify the states with the highest and lowest insurance penetration. 
-- This will help prioritize regions for marketing and customer outreach initiatives.

SELECT 
    state,
    SUM(insurance_count) AS total_insurance_count,
    SUM(insurance_amount) AS total_insurance_amount
FROM 
    Aggregated_Insurance
GROUP BY 
    state
ORDER BY 
    total_insurance_count DESC;

-- use case 2 Inusrance adoption by year and quarter
-- Business Benefit: This simplifies the query and analysis, especially if you dont need to differentiate by
--  insurance_type (since it is the same for all rows).
-- It allows you to focus on the year and quarter to track trends in insurance adoption over time

SELECT 
    CONCAT(`Year`, '-Q', `Quarter`) AS `Year_Quarter`,  
    SUM(`Insurance_count`) AS `total_insurance_count`,
    SUM(`Insurance_amount`) AS `total_insurance_amount`
FROM 
    `aggregated_insurance`
GROUP BY 
    `Year`, `Quarter`
ORDER BY 
    `Year`, `Quarter`;




-- use case 3 -State-Wise Comparison of Insurance Adoption (By Quarter and Year)
-- Business Objective: Compare the insurance adoption (count and amount) between different states within the same
-- quarter/year to analyze regional variations and identify where improvements can be made.
-- Goal: Identify outliers and regions where adoption may be underperforming relative to other states, 
-- allowing PhonePe to develop more targeted strategies for underperforming states.

SELECT 
    state,
    CONCAT(Year, '-Q', Quarter) AS Year_Quarter,
    SUM(insurance_count) AS total_insurance_count,
    SUM(insurance_amount) AS total_insurance_amount
FROM 
    Aggregated_Insurance 
GROUP BY 
    state, Year, Quarter
ORDER BY 
    Year_Quarter, total_insurance_count DESC;



-- use Case 4 : Insurance Adoption by Season
-- Objective: Analyze the adoption of insurance products based on seasons (Spring, Summer, Fall, Winter) to identify
--  if certain times of the year have higher or lower adoption rates.
-- SQL Query: You can categorize the data into seasons using the quarter field. In most countries, each quarter 
-- roughly corresponds to a season:

-- Q1 (January - March): Winter
-- Q2 (April - June): Spring
-- Q3 (July - September): Summer
-- Q4 (October - December): Fall


SELECT 
    state,
    CASE 
        WHEN Quarter = 1 THEN 'Winter'
        WHEN Quarter = 2 THEN 'Spring'
        WHEN Quarter = 3 THEN 'Summer'
        WHEN Quarter = 4 THEN 'Autumn'
    END AS Season,
    SUM(insurance_count) AS total_insurance_count,
    SUM(insurance_amount) AS total_insurance_amount
FROM 
    Aggregated_Insurance
GROUP BY 
    state, Season
ORDER BY 
    Season, total_insurance_count DESC;

