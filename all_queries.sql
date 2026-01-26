**Question 1)** Provide a list of products with a base price greater than 500 and that are featured in promo type of 'BOGOF' (Buy One Get One Free).
This information will help us identify high-value products that are currently being heavily discounted, 
which can be useful for evaluating our pricing and promotion strategies.

**Query** :- SELECT distinct (p.product_name), f.base_price from fact_events f 
join dim_products p on f.product_code = p.product_code 
where f.promo_type = "BOGOF" and f.base_price > 500;

**Question 2)**	Generate a report that provides an overview of the number of stores in each city. The results will be sorted in descending 
  order of store counts, allowing us to identify the cities with the highest store presence. 
  The report includes two essential fields: city and store count, which will assist in optimizing our retail operations.

**Query** :- Select city , count(store_id) as Total_Store
from dim_stores 
group by city 
order by Total_Store desc;
