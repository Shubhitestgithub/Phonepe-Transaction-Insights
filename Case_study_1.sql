-- Decoding Transaction Dynamics on PhonePe

Show Databases;

USE phonepe_pulse;

-- use case 1 State Level Transaction Trends
select state, SUM(transaction_count) as total_transactions,
SUM(transaction_amount) as total_transaction_value
from aggregated_transaction
Group by state
order by total_transactions DESC;


-- use case 2-  Analyzing discrepancies between transaction counts and amounts by category
-- Category Insights: Analyze transaction categories (e.g., Recharge & Bill Payments, Peer-to-Peer Payments)
--  to uncover discrepancies between their transaction counts and monetary contributions. 
-- Are certain categories driving high volumes but low revenue, or vice versa?
-- Query to compare transaction categories based on counts and monetary contributions.
SELECT transaction_type, 
       SUM(transaction_count) AS total_transaction_count, 
       SUM(transaction_amount) AS total_transaction_amount,
       (SUM(transaction_amount) / SUM(transaction_count)) AS avg_value_per_transaction  
FROM Aggregated_transaction
GROUP BY transaction_type
ORDER BY total_transaction_count DESC, total_transaction_amount DESC;

 -- use case 3 - To identify seasonal or quarterly patterns, we will check for spikes in transaction behavior across different quarters
-- Trend Analysis: Determine if there are seasonal or quarterly patterns influencing transaction behavior. 
-- Are there spikes in specific quarters, and if so, what might be causing them?

SELECT 
  CONCAT(`year`, '-', `quarter`) AS `Year_Quarter`,  -- Combines Year and Quarter
  SUM(`transaction_count`) AS `total_transaction_count`, 
  SUM(`transaction_amount`) AS `total_transaction_amount`
FROM `Aggregated_transaction`
GROUP BY year, quarter  -- Group by the combined Year and Quarter
ORDER BY `Year_Quarter`;


-- use case 4 - identify the states or regions where transaction volumes and values are consistently low
-- Regional Performance Analysis: Identify states or regions where transaction volumes and values are consistently low.
--  Are these regions underperforming across all payment categories or specific ones?
SELECT state, 
       transaction_type,
       SUM(transaction_count) AS total_transaction_count, 
       SUM(transaction_amount) AS total_transaction_amount
FROM Aggregated_Transaction
GROUP BY state, transaction_type
HAVING SUM(transaction_count) < 
        (SELECT AVG(total_count)
         FROM (SELECT SUM(transaction_count) AS total_count
               FROM Aggregated_Transaction
               GROUP BY state) AS subquery)
   OR SUM(transaction_amount) < 
        (SELECT AVG(total_amount)
         FROM (SELECT SUM(transaction_amount) AS total_amount
               FROM Aggregated_Transaction
               GROUP BY state) AS subquery)
order by total_transaction_count, total_transaction_amount;


