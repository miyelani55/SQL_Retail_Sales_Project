-- SQL Retail Sales Analysis

-- Create table
drop table if exists retail_sales;
create table retail_sales (

transactions_id int PRIMARY KEY,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);
select * from retail_sales;

select count(*) from retail_sales;

---Data cleaning
select * from retail_sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or 
customer_id is null
or 
gender is null
or
age is null
or
category is null
or 
quantiy is null
or
price_per_unit is null
or 
cogs is null
or
total_sale is null
;

---

delete from retail_sales
where
sale_date is null
or
sale_time is null
or 
customer_id is null
or 
gender is null
or
age is null
or
category is null
or 
quantiy is null
or
price_per_unit is null
or 
cogs is null
or
total_sale is null;

--- verify remaining records after deleting

select count(*) from retail_sales;

--Data exploration

--How many sales do we have?

select count(*) as total_sales
from retail_sales

-- How many unique customers do we have ?

select count(DISTINCT customer_id) as total_sales 
from retail_sales;

-- How many categories do we have ?


select count(DISTINCT category) as total_sales 
from retail_sales;

--list of categories we have
select distinct category
from retail_sales

--Data analysis and Business key problems

-- My Analysis and Findings

--Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05';

--Q2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 3 in the month of Nov-2022


select * 
from retail_sales
where category = 'Clothing'
and TO_CHAR(sale_date, 'YYYY-MM')= '2022-11'
and quantiy > 3;

---Q3 Write a SQL query to CALCULATE the total sales for each category

select category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1



--Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' cat

select
round(avg(age), 2) as average_age
from retail_sales
where category = 'Beauty'

--Q5 Write a SQL query to find top 5 customers based on highest total sales
  
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


--Q6 wrire a sql query to create each shift and number of otders (moring<=12, afternoon between 12 and 17h000, evening >17h00)

with hourly_sale
as
(
select *,
  case 
      when extract (hour from sale_time) <12 then 'morning'
      when extract (hour from sale_time) between 12 and 17 then 'afternoon'
      else 'evening'
  end as shift
from retail_sales
)
select 
shift,
count(*) as total_orders
from hourly_sale
group by shift
