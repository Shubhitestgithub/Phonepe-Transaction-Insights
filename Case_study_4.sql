-- Transaction Analysis for Market Expansion
use phonepe_pulse;

select * from map_user;

-- use case 1 : App Open Frequency by State and Quarter (Active vs Passive Users)
-- Objective:
-- Identify the active users versus passive users by analyzing app open frequency (number of times the app was opened)
-- across quarters.

-- Query to classify users as active or passive based on their app opens
SELECT 
    CONCAT(year, '-', quarter) AS year_quarter,  -- Concatenate year and quarter
    SUM(registered_users) AS total_registered_users,
    SUM(app_opens) AS total_app_opens,
    COUNT(CASE WHEN app_opens > 5 THEN 1 END) AS active_users,  -- Users who opened the app more than 5 times
    COUNT(CASE WHEN app_opens <= 5 THEN 1 END) AS passive_users,  -- Users who opened the app 5 or fewer times
    (COUNT(CASE WHEN app_opens > 5 THEN 1 END) / SUM(registered_users)) * 100 AS active_user_percentage,
    (COUNT(CASE WHEN app_opens <= 5 THEN 1 END) / SUM(registered_users)) * 100 AS passive_user_percentage
FROM 
    Map_user
GROUP BY 
     year_quarter  -- Grouping by concatenated year_quarter
ORDER BY 
     year_quarter;  -- Ordering by concatenated year_quarter



-- use case  2  Quarterly Growth in Registered Users
-- Objective:
-- Understand the quarterly growth in the number of registered users to forecast future growth and plan marketing
--  strategies.

-- Query to analyze quarterly growth in the number of registered users
SELECT 
    CONCAT(year, '-', quarter) AS year_quarter,  
    SUM(registered_users) AS total_registered_users,
    IFNULL(LAG(SUM(registered_users)) OVER (ORDER BY year, quarter), 0) AS previous_quarter_users,
    SUM(registered_users) - IFNULL(LAG(SUM(registered_users)) OVER (ORDER BY year, quarter), 0) AS growth_in_registered_users
FROM 
    Map_user
GROUP BY 
    year, quarter
ORDER BY 
    year, quarter;


-- use case 3 User Engagement by State and Quarter
-- Objective:
-- Analyze user engagement across different states over time to understand growth trends and identify potential 
-- market opportunities.

-- Query to analyze user engagement by state and quarter
SELECT 
    state, 
    CONCAT(year, '-', quarter) AS year_quarter,
    SUM(registered_users) AS total_registered_users,  -- Total number of registered users
    SUM(app_opens) AS total_app_opens,  -- Total number of app opens
    (SUM(app_opens) / SUM(registered_users))  AS engagement_rate  -- Engagement rate as a percentage
FROM 
    Map_user
GROUP BY 
    state, year, quarter
ORDER BY 
    state, year,quarter;
