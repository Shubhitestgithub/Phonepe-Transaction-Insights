**PhonePe Pulse Data Analysis & Visualization Project**

**Problem Statement**

With the increasing reliance on digital payment systems like PhonePe,  understanding the dynamics of transactions, user engagement, and insurance-related data is crucial. This project aims to:  
\- Analyze and visualize aggregated values of payment categories.  
\- Create geographic maps of total transaction values at state and district levels.  
\- Identify top-performing states, districts, and pin codes.

**Project Approach**

**1.Data Extraction**  
\- Clone the \[PhonePe Pulse GitHub Repository\](https://github.com/PhonePe/pulse.git).  
\- Extract transaction, user, and insurance data from JSON files.

**2.SQL Database and Table Setup**  
Use a relational database (e.g., MySQL, PostgreSQL) to store structured data:

 **Aggregated Tables:**

1. **Aggregated\_user**: Stores aggregated data related to users.  
2. **Aggregated\_transaction:** Contains aggregated transaction values for mapping data.  
3. **Aggregated\_insurance:** Holds aggregated data related to insurance transactions.

   **Map Tables:**

1. **Map\_user:** Stores mapping information related to users.  
2. **Map\_map:** Contains mapping data for total transaction amounts at the state and district levels.  
3. **Map\_insurance**: Holds mapping information for insurance transactions at various locations.

    **Top Tables:**

1. **Top\_transaction\_district:** Stores transaction data at the district level, including transaction count, amount, and type for each state, year, and quarter.  
2. **Top\_transaction\_pincode:** Stores transaction data at the pin code level, including transaction count, amount, and type for each state, year, and quarter.  
3. **Top\_users\_district:** Stores data on registered users at the district level for each state, year, and quarter.  
4. **Top\_users\_pincode:** Stores data on registered users at the pin code level for each state, year, and quarter.  
5. **Top\_insurance\_district:** Stores insurance transaction data at the district level, including count, amount, and type of insurance for each state, year, and quarter.  
6.  **Top\_insurance\_pincode:** Stores insurance transaction data at the pin code level, including count, amount, and type of insurance for each state, year, and quarter.

 **3\. SQL Queries**  
Use SQL queries for:  
\- Deriving business insights  
\- Extracting regional, temporal, and categorical trends

 **4.Python Data Analysis**  
Utilize Python for deeper analysis and visualizations:  
\- Libraries Used: \`pandas\`  
\- Visualizations:  
  \- Aggregated bar charts  
  \- Pie charts for category distributions  
  \- Line charts for trend analysis

**5\. Dashboard Creation**  
Build an interactive dashboard using Tableau

Dashboard Features:  
\- Transaction trends by state/district  
\- User and insurance data insights  
\- Top-performing regions and categories  
\- Drill-down capability for granular analysis

**6\. Key Insights & Recommendations**  
\- Highlight regions with the highest digital adoption  
\- Spot trends in transaction types and seasonal patterns  
\- Identify high-value customers for targeted retention  
\- Recommend feature enhancements and new insurance offerings

**Author:**  
Shubhi Garg

