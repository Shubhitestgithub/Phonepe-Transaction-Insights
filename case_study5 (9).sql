 -- Insurance Transactions Analysis
use phonepe_pulse;
select * from top_insurance_district;
select * from top_insurance_pincode;

-- use case 1 - Identifying Top States:
-- Determine the top 10 states based on the total number of transactions and total transaction value for the selected year-quarter
--  combination.
-- Analyze which states show consistent transaction volume over multiple quarters.

-- Retrieve the top 10 states by total transactions and amount for the most recent year-quarter combination.

SELECT 
    state,  -- Retrieve the state
    MAX(year) AS year,  -- Fetch the most recent year
    MAX(quarter) AS quarter,  -- Fetch the most recent quarter
    SUM(insurance_count) AS total_transaction_count,  -- Calculate total number of insurance transactions per state
    SUM(insurance_amount) AS total_transaction_amount  -- Calculate total transaction value per state
FROM 
    top_insurance_district  -- Query the top_insurance_district table
WHERE 
    year = (SELECT MAX(year) FROM top_insurance_district)  -- Filter for the most recent year
    AND quarter = (SELECT MAX(quarter) FROM top_insurance_district WHERE year = (SELECT MAX(year) FROM top_insurance_district))  -- Filter for the most recent quarter within that year
GROUP BY 
    state  -- Group results by state to aggregate transaction counts and amounts
ORDER BY 
    total_transaction_count DESC  -- Order results by transaction count in descending order
LIMIT 10;  -- Limit the results to the top 10 states



-- use case 2: percentage share of each state and district in the overall insurance transactions
--  Calculate the total insurance count and amount for each state and district, and their percentage share in the overall transactions

SELECT 
    state,  -- Retrieve the state
    district,  -- Retrieve the district
    SUM(insurance_count) AS total_insurance_count,  -- Total number of insurance transactions for each district
    SUM(insurance_amount) AS total_insurance_amount,  -- Total insurance transaction amount for each district
    -- Calculate the percentage share of insurance count for each district relative to the total transactions across all years and quarters
    (SUM(insurance_count) / 
        (SELECT SUM(insurance_count) 
         FROM top_insurance_district
        )) * 100 AS percentage_share_count,
    -- Calculate the percentage share of insurance amount for each district relative to the total transactions across all years and quarters
    (SUM(insurance_amount) / 
        (SELECT SUM(insurance_amount) 
         FROM top_insurance_district
        )) * 100 AS percentage_share_amount
FROM 
    top_insurance_district  -- Query the top_insurance_district table
GROUP BY 
    state, district  -- Group results by state and district to calculate the total counts and amounts for each district
ORDER BY 
    percentage_share_count DESC;  -- Order by the percentage share of count in descending order (most significant districts first)




-- use case 3: District Performance Evaluation:
-- Determine the top 10 districts within the top states that contributed to insurance transactions.
-- Investigate factors contributing to higher insurance transactions in specific districts.

SELECT 
    t.state, 
    t.district, 
    SUM(t.insurance_count) AS total_insurance_count,  -- Total number of insurance transactions
    SUM(t.insurance_amount) AS total_insurance_amount  -- Total amount of insurance transactions
FROM 
    top_insurance_district t  -- Query the insurance transactions data by district
JOIN 
    (  -- Subquery to get the top 10 states
        SELECT state
        FROM top_insurance_district
        GROUP BY state
        ORDER BY SUM(insurance_count) DESC  -- Ordering by the total insurance count across all districts in that state
        LIMIT 10
    ) AS top_states ON t.state = top_states.state  -- Join with the top states
GROUP BY 
    t.state, t.district  -- Group by state and district to calculate the totals per district
ORDER BY 
    total_insurance_count DESC  -- Order by transaction count in descending order
LIMIT 10;  -- Get the top 10 districts



-- use case 4  Pin Code Insights:
-- Analyze the top 10 pin codes with the highest number of insurance transactions.
-- Explore any demographic or geographic characteristics associated with these pin codes.
SELECT 
    pincode,  -- Retrieve the pincode
    SUM(insurance_count) AS total_insurance_count,  -- Total number of insurance transactions
    SUM(insurance_amount) AS total_insurance_amount  -- Total amount of insurance transactions
FROM 
    Top_insurance_pincode  -- Query the insurance transactions data by pincode
GROUP BY 
    pincode  -- Group by pincode to get totals per pincode
ORDER BY 
    total_insurance_count DESC  -- Order by transaction count (descending)
LIMIT 10;  -- Get the top 10 pin codes

