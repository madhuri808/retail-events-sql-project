# retail-events-sql-project

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
See all_queries.sql

**Output:**  
![High Value BOGOF Products](outputs/Q1)Answer.jpeg)
  
**Insight:**  
Only two premium products with base prices above ₹1000 are currently included in BOGOF promotions. This suggests that the BOGOF strategy is selectively applied to high-value household items, likely to drive higher sales volumes for expensive products during festive periods.


