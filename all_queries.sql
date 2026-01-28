Question 1) Provide a list of products with a base price greater than 500 and that are featured in promo type of 'BOGOF' (Buy One Get One Free).
This information will help us identify high-value products that are currently being heavily discounted, 
which can be useful for evaluating our pricing and promotion strategies.

Query :- SELECT distinct (p.product_name), f.base_price from fact_events f 
join dim_products p on f.product_code = p.product_code 
where f.promo_type = "BOGOF" and f.base_price > 500;

Question 2)	Generate a report that provides an overview of the number of stores in each city. The results will be sorted in descending 
order of store counts, allowing us to identify the cities with the highest store presence. 
The report includes two essential fields: city and store count, which will assist in optimizing our retail operations.

Query :- Select city , count(store_id) as Total_Store
from dim_stores 
group by city 
order by Total_Store desc;

Question 3) Generate a report that displays each campaign along with the total revenue generated before and after the campaign? 
The report includes three key fields: campaign _name, total revenue(before_promotion), total revenue(after_promotion). 
This report should help in evaluating the financial impact of our promotional campaigns. (Display the values in millions)

Query :- select c.campaign_name , 
concat(round(sum(f.base_price * f.`quantity_sold(before_promo)`)/1000000,2),' mln') as 
revenue_before_promo_mln, 
concat(round(sum(f.base_price * f.`quantity_sold(after_promo)`)/1000000,2), ' mln') as 
revenue_after_promo_mln from fact_events f join dim_campaigns c
on c.campaign_id = f.campaign_id
group by c.campaign_name;

Question 4)Produce a report that calculates the Incremental Sold Quantity (ISU%) for each category during the Diwali campaign.
Additionally, provide rankings for the categories based on their ISU%. The report will include three key fields: category, isu%, 
and rank order. This information will assist in assessing the 
category-wise success and impact of the Diwali campaign on incremental sales.

 Query :- with category_sales as (select p.category , c.campaign_name,
f.`quantity_sold(before_promo)` as qty_before_promo ,
case when f.promo_type = "BOGOF" then f.`quantity_sold(after_promo)`*2 
else f.`quantity_sold(after_promo)` end as qty_after_promo 
from fact_events f join dim_campaigns c on c.campaign_id = f.campaign_id
join dim_products p on p.product_code = f.product_code
where c.campaign_name = "Diwali"),
isu_percentage as (
select campaign_name, category ,
round((sum(qty_after_promo )-sum(qty_before_promo))/sum(qty_before_promo)*100,2) as isu_percent
from category_sales group by campaign_name, category)
select  category , isu_percent , 
rank () over (order by isu_percent desc ) as rank_order
from isu_percentage 
order by rank_order;


Question 5)Create a report featu ring the Top 5 products, ranked by Incremental Revenue Percentage (IR%), across all campaigns.
The report will provide essential information including product name, category, and ir%.
This analysis helps identify the most successful products in terms of incremental revenue across our campaigns, assisting in product optimization

 Query :- WITH revenue_normalized AS (
    SELECT
        dp.product_name,
        dp.category,
       -- Revenue BEFORE promotion (base price × quantity before promo)
        fe.base_price * fe.`quantity_sold(before_promo)` AS revenue_before,
      -- Revenue AFTER promotion (adjusted by promo type)
        CASE
            WHEN fe.promo_type = 'BOGOF'
                THEN fe.base_price * 0.5 * (fe.`quantity_sold(after_promo)` * 2)
            WHEN fe.promo_type = '500 Cashback'
                THEN (fe.base_price - 500) * fe.`quantity_sold(after_promo)`
            WHEN fe.promo_type = '50% OFF'
                THEN fe.base_price * 0.5 * fe.`quantity_sold(after_promo)`
            WHEN fe.promo_type = '33% OFF'
                THEN fe.base_price * 0.67 * fe.`quantity_sold(after_promo)`
            WHEN fe.promo_type = '25% OFF'
                THEN fe.base_price * 0.75 * fe.`quantity_sold(after_promo)`
            ELSE 0
        END AS revenue_after
    FROM fact_events fe
    JOIN dim_products dp
        ON fe.product_code = dp.product_code
    JOIN dim_campaigns dc
        ON fe.campaign_id = dc.campaign_id
),

product_revenue AS (
    SELECT
        product_name,
        category,
        SUM(revenue_before) AS total_revenue_before,
        SUM(revenue_after) AS total_revenue_after
    FROM revenue_normalized
    GROUP BY product_name, category
),

ir_calculation AS (
    SELECT
        product_name,
        category,
        ROUND(
            ((total_revenue_after - total_revenue_before)
             / total_revenue_before) * 100,
            2
        ) AS ir_percent
    FROM product_revenue
)

SELECT
    product_name,
    category,
    ir_percent,
    RANK() OVER (ORDER BY ir_percent DESC) AS rank_order
FROM ir_calculation
ORDER BY rank_order
LIMIT 5;

