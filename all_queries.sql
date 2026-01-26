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

