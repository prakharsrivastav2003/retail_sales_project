select * from retaildata;
--Data Cleaning

select count(*) from retaildata;

select count(distinct customer_id) from retaildata;

select distinct category from retaildata;

select * from retaildata
where 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR  category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

    delete  from retaildata
where 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR  category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

    --Data Exploration
    --How many sales we have

    select count(transactions_id)as total_sales from retaildata;

    -- How many unique customer we have

    select count(distinct customer_id) as unique_customers from retaildata;

    -- How many unique category we have

        select count(distinct category) as unique_customers from retaildata;

   -- Data Analysis
   -- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retaildata
where sale_date = '2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select * from retaildata 
where category = 'clothing' and quantity > 3 and sale_date >= '2022-11-1' and sale_date < '2022-12-1';
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category , concat('Rs ', sum(total_sale))as total_sales 
from retaildata
group by category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round( avg(age),2)as avg_age from retaildata
where category = 'beauty';
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retaildata
where total_sale > 1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category , gender , count(transactions_id)as Total_Transactions
from retaildata
group by category , gender;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
with monthly_avg as(
select 
year(sale_date) as sale_year,
month(sale_date) as sale_month,
avg(total_sale) as avg_sales

from retaildata
group by year(sale_date) ,
month(sale_date)),
ranked_months as (
select * , 
rank() over(partition by sale_year order by avg_sales desc) as Max_sale_rank
from monthly_avg)
select
sale_year, sale_month , avg_sales
from 
ranked_months
where
max_sale_rank = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.
select top 5 * from(
select customer_id , sum(total_sale) as total_sales
from retaildata
group by customer_id) as sales_summary
order by total_sales desc;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category , 
count(distinct customer_id) as count_of_unique_customer
from retaildata
group by category;
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
with shift_table as
(
select * ,
case 
when datepart(hour,sale_time) >12 then 'Morning'
when datepart(hour,sale_time) between 12 and 17 then 'Afternoon'
else 'Evening' 
end as shifts
from retaildata
)
select 
shifts , count(*) as Orders
from shift_table
group by shifts 
order by Orders desc;

--end of project








     
 

