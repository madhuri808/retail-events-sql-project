Question 1) Provide a list of products with a base price greater than 500 and that are featured in promo type of 'BOGOF' (Buy One Get One Free).
This information will help us identify high-value products that are currently being heavily discounted, 
which can be useful for evaluating our pricing and promotion strategies.

Query :- SELECT distinct (p.product_name), f.base_price from fact_events f 
join dim_products p on f.product_code = p.product_code 
where f.promo_type = "BOGOF" and f.base_price > 500;

