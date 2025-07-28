# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure
**Data was imported from a excel file.**

```

### 1. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from retaildata
where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
select * from retaildata 
where category = 'clothing' and quantity > 3 and sale_date >= '2022-11-1' and sale_date < '2022-12-1';

```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category , concat('Rs ', sum(total_sale))as total_sales 
from retaildata
group by category;

```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select round( avg(age),2)as avg_age from retaildata
where category = 'beauty';

```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from retaildata
where total_sale > 1000;

```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category , gender , count(transactions_id)as Total_Transactions
from retaildata
group by category , gender;

```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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

```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select top 5 * from(
select customer_id , sum(total_sale) as total_sales
from retaildata
group by customer_id) as sales_summary
order by total_sales desc;

```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select category , 
count(distinct customer_id) as count_of_unique_customer
from retaildata
group by category;

```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Prakhar Srivastav

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. 



Thank you 
