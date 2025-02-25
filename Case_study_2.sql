-- Device Dominance and User Engagement Analysis
Show Databases;

USE phonepe_pulse;

-- CASE STUDY 2

-- use case 1 - Device Brand Analysis:
-- Identify top-performing device brands based on user registrations and app opens.
-- Compare user engagement (app opens) to registration rates for each device brand to detect underperforming or overperforming brands.

SELECT 
    brand,
    SUM(user_count_by_brand) AS total_registered_users_by_brand,
    SUM(app_opens) AS total_app_opens,
    (SUM(app_opens) / SUM(user_count_by_brand)) AS engagement_rate
FROM 
    Aggregated_Users
GROUP BY 
    brand
ORDER BY 
    engagement_rate DESC, total_registered_users_by_brand DESC;
    
-- use case 2 - Regional Trends:
-- Explore state-wise variations in device preferences.
-- Are certain brands dominant in specific regions? What might explain regional variations?
select * from aggregated_users;
SELECT 
    state,
    brand,
    SUM(user_count_by_brand) AS total_registered_users,
    SUM(app_opens) AS total_app_opens
FROM 
    Aggregated_Users
GROUP BY 
    state, brand
ORDER BY 
    state, total_registered_users DESC;

    
-- use case 3 - Market Potential:
-- Highlight brands with lower market penetration but strong engagement rates.

SELECT 
    `aggregated_users`.`Brand` AS `Brand`,
    SUM(`aggregated_users`.`user_count_by_brand`) AS `total_users_by_brand`,
    SUM(`aggregated_users`.`App_Opens`) AS `total_app_opens`,
    (SUM(`aggregated_users`.`App_Opens`) / SUM(`aggregated_users`.`user_count_by_brand`)) AS `engagement_rate` 
FROM `aggregated_users`
GROUP BY `aggregated_users`.`Brand`
HAVING 
    SUM(`aggregated_users`.`user_count_by_brand`) < (SELECT AVG(`user_count_by_brand`) FROM `aggregated_users`)
ORDER BY `engagement_rate` DESC, `total_users_by_brand` ASC;


-- use case 4 - User Loyalty:
-- Analyze the "Others" category to understand the impact of unrecognized devices. 
-- Are these users more or less engaged compared to users on recognized devices?

    SELECT 
    brand,
    SUM(user_count_by_brand) AS total_users_by_brand,   -- Total registered users for each brand
    SUM(app_opens) AS total_app_opens,                   -- Total app opens for each brand
    (SUM(app_opens) / SUM(user_count_by_brand)) AS engagement_rate  -- Engagement rate: app_opens / registered_user
FROM 
    Aggregated_Users
GROUP BY 
    brand
HAVING 
    brand = 'Others' OR brand != 'Others'  
ORDER BY 
    engagement_rate DESC;

