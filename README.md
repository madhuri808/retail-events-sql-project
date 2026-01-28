# Retail-events-sql-project

Domain: FMCG Function: Sales / Promotions

Project Description:

AtliQ Mart is a retail giant with over 50 supermarkets in the southern region of India. All their 50 stores ran a massive promotion during the Diwali 2023 and Sankranti 2024 (festive time in India) on their AtliQ branded products. Now the sales director wants to understand which promotions did well and which did not so that they can make informed decisions for their next promotional period.

Sales director Bruce Haryali wanted this immediately but the analytics manager Tony is engaged on another critical project. Tony decided to give this work to Peter Pandey who is the curious data analyst of AtliQ Mart. Since these insights will be directly reported to the sales director, Tony also provided some notes to Peter to support his work.

---

## 🗄️ Database Information
- Database Name: `retail_events_db`
- Tables Used:
  - `fact_events` – transactional sales and promotion data
  - `dim_products` – product master data
  - `dim_stores` –  stores master data
  - `dim_campaigns` – 
- Database Tool: MySQL Workbench

## 🛠️ Tools & Technologies
- MySQL
- MySQL Workbench
- GitHub

---

## 📊 Business Questions & Analysis
### 1. High-Value Products under BOGOF Promotion

**Business Question:**  
Provide a list of products with a base price greater than 500 that are featured in a BOGOF (Buy One Get One Free) promotion.

**SQL Logic Used:**  
Joined `fact_events` and `dim_products` tables using `product_code` and filtered records where `base_price > 500` and `promo_type = 'BOGOF'`.

**SQL Query:**  
[View all SQL queries](all_queries.sql)


**Output:**  
![Q1 High Value BOGOF Products](outputs/q1_answer.jpeg)

  
**Insight:**  
Only two premium products with base prices above ₹1000 are currently included in BOGOF promotions. This suggests that the BOGOF strategy is selectively applied to high-value household items, likely to drive higher sales volumes for expensive products during festive periods.

### 2. Store Distribution by City

**Business Question:**  
Generate a report showing the number of stores in each city, sorted by store count in descending order.

**SQL Logic Used:**  
Aggregated store data from `dim_stores` by grouping records at the city level and counting the number of stores per city.

**SQL Query:**  
[View SQL queries](all_queries.sql)

**Output:**  
![Store Count by City](outputs/q2_store_count_by_city.png)


**Insight:**  
Bengaluru has the highest store presence with 10 stores, followed by Chennai (8) and Hyderabad (7), indicating a strong focus on major metro markets. In contrast, tier-2 cities such as Trivandrum and Vijayawada have relatively lower store counts, suggesting potential opportunities for targeted expansion in these regions.

### 3. Campaign-wise Revenue Before and After Promotion

**Business Question:**  
Generate a report that displays each campaign along with the total revenue generated before and after the promotion. The report helps evaluate the financial impact of promotional campaigns. (Revenue values are shown in millions.)

**SQL Logic Used:**  
Joined the `fact_events` and `dim_campaigns` tables using `campaign_id`. Revenue was calculated by multiplying base price with quantity sold before and after promotion, aggregating the results at the campaign level, and converting the values into millions.

**SQL Query:**  
[View SQL queries](all_queries.sql)

**Output:**  
![Campaign Revenue Before and After Promotion](outputs/q3_campaign_revenue.png)


**Insight:**  
Both Diwali and Sankranti campaigns delivered a substantial uplift in revenue after promotion. Diwali emerged as the stronger campaign, increasing revenue from 82.57 mln to 207.46 mln, while Sankranti grew from 58.13 mln to 140.40 mln. This indicates that festive promotions had a strong positive financial impact, with Diwali campaigns outperforming Sankranti in overall revenue generation.

### 4. Incremental Sold Quantity (ISU%) by Category – Diwali Campaign

**Business Question:**  
Produce a report that calculates the Incremental Sold Quantity Percentage (ISU%) for each product category during the Diwali campaign and ranks the categories based on their ISU%. This analysis helps assess the category-wise success and impact of the Diwali promotional campaign on incremental sales.

**SQL Logic Used:**  
Filtered data for the Diwali campaign and joined `fact_events`, `dim_campaigns`, and `dim_products` tables to obtain category-level information. Post-promotion quantities were adjusted for BOGOF offers to reflect actual units sold. Category-wise quantities sold before and after promotion were aggregated, ISU% was calculated using the defined formula, and categories were ranked based on ISU%.

**SQL Query:**  
[View SQL queries](all_queries.sql)

**Output:**  
![ISU Percentage by Category – Diwali](outputs/q4_isu_by_category.png)

**Insight:**  
The ISU% analysis reveals notable differences in incremental sales performance across product categories during the Diwali campaign. Categories with higher ISU% demonstrated a stronger uplift in units sold after promotion, indicating greater customer responsiveness to festive offers. This insight highlights which categories benefited most from the Diwali campaign and can guide future category-focused promotional strategies.





