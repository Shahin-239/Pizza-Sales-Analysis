CREATE TABLE pizza_sales (
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price NUMERIC(10,2),
    total_price NUMERIC(10,2),
    pizza_size VARCHAR(20),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);

select * from pizza_sales;

-- KPI
--1. TOTAL REVENUE
select sum(total_price) as Total_Revenue from pizza_sales;
-- 2. TOTAL ORDERS 
select count(distinct order_id) as total_orders from pizza_sales;
-- 3. AVERAGE ORDER VALUE

select 
      round(
	  sum(total_price)/ count(distinct order_id),
	  2)
	  as avg_order_value
from pizza_sales;

-- 4. TOTAL PIZZAS SOLD 
select 
      sum(quantity) as total_pizza_sold
from pizza_sales;	  

-- 5. AVERAGE PIZZAS PER ORDER
select 
     round(
	 sum(quantity):: numeric/ 
	 count(distinct order_id), 2)
	 as avg_pizza_per_order
from pizza_sales;

-- ANALYSIS
-- 1.Monthly Trend for Total Revenue 
select to_char(order_date , 'Month') as MONTH ,
        sum(quantity) as Total_Revenue
from pizza_sales
group by to_char(order_date, 'Month');

-- 2. Daily Trend for Total Orders
select to_char(order_date , 'DAY') as MONTH ,
       count(distinct order_id) as Total_Orders
from pizza_sales
group by to_char(order_date, 'DAY');

-- 3. Percentage of Sales by Pizza Category
select pizza_category,
       sum(total_price) as total_revenue,
	   round(sum(total_price)* 100/
	   (select sum(total_price) from pizza_sales),2) as pct 
from pizza_sales
group by pizza_category;

-- 4. Percentage of Sales by Pizza Size
select pizza_size,
       sum(total_price) as total_revenue,
	   round(sum(total_price)* 100/
	   (select sum(total_price) from pizza_sales),2) as pct 
from pizza_sales
group by pizza_size;

-- 5. Total Pizza Sold yby Pizza Size and Category
select 
     pizza_size,
	 sum(quantity) as total_quantity
from pizza_sales
group by pizza_size;

select 
     pizza_category,
	 sum(quantity) as total_quantity
from pizza_sales
group by pizza_category;

-- 6. Revenue by Pizza Name
select 
     pizza_name,
	 sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name order by Total_Revenue desc;

-- Top & Bottom Analysis
-- 1. Top Pizza by Revenue
select 
     pizza_name,
	 sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name order by Total_Revenue desc
limit 5;

-- 2. Bottom Prizza by Revenue 
select 
     pizza_name,
	 sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name order by Total_Revenue asc
limit 5;
-- 3. Top 5 Pizza by Orders 
select 
     pizza_name,
	 count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name order by total_orders desc
limit 5;

-- 4. bottom 5 Pizza by Orders 
select 
     pizza_name,
	 count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name order by total_orders asc
limit 5;

-- 4. Top 5 Pizza by Quantity Sold
select 
     pizza_name,
	 sum(quantity) as total_quantity_sold
from pizza_sales
group by pizza_name order by total_quantity_sold desc
limit 5;

-- 5. Bottom 5 pizza by Quantity Sold
select 
     pizza_name,
	 sum(quantity) as total_quantity_sold
from pizza_sales
group by pizza_name order by total_quantity_sold asc
limit 5;









