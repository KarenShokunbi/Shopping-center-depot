
/*This is a E-commerce dataset of a fictitious sales company which sells a total 157 products which are categorise into four sections.
The Fashion category, Home and furnitures category, Auto and accessories catergory, Electronic category. 
A descriptive, comparative, and predictive data analysis were performed using the queries below*/

--This query show the whole dataset
select*
from [E-commence-data-set]

-- What devices do my client use to reach me?
--This query show the type of device used by the customers to access the sales platform.
/*The COUNT function helps identify the most commonly used device by each customer.
This process involves grouping data by device type, counting the occurrences for each device,
and then determining which device has the highest frequency of use.*/
select Device_Type, count(Device_Type) as MostUsedDevice
from [E-commence-data-set]
group by Device_Type
order by MostUsedDevice Desc;

--Who is the customer base?
/*This query analyzes the company’s customer base by gender. 
In this query, we used the gender and customer_id columns to count the unique number of customers (using COUNT(DISTINCT customer_id)) for each gender.
The results are grouped by gender to show a breakdown of the customer count by gender.
This gives insight into how many unique customers identify with each gender.*/
SELECT Gender, COUNT (DISTINCT Customer_Id) AS Customer_Count
FROM [E-commence-data-set]
GROUP BY Gender;

-- What product categories am I selling?
/*This query identifies the different product categories being sold by grouping data by the product category column.
By grouping, it lists each unique category available in the data set.
Ordering by product category in ascending order arranges these categories alphabetically, giving a structured view of all categories represented in the database.
This provides a clear look at each category available in the data set without additional metrics.*/
select Product_Category
from [E-commence-data-set]
group by Product_Category
order by Product_Category;

--Which product categories do I sell to whom? (Gender Distribution by Category or Product?)
/*This query examines the distribution of product categories across customer genders to understand which categories are sold to each demographic.
By selecting gender, product, and product category, and then grouping by these columns,
the query reveals which genders are purchasing specific products within each product category.
This query highlights customer preferences for certain products and categories based on gender,
giving insights into target demographics for each product category*/
select Gender, Product_Category, Product
from [E-commence-data-set]
group by Gender, Product_Category, Product
order by Product_Category;

-- Which login type do my customers prefer when shopping?
/*This query identifies which login types are most preferred by customers when shopping.
By selecting customer login type and counting customer_id as total customers, it calculates the number of customers using each login type.
Grouping by customer login type and ordering by total customers in descending order, ranks the login types from most to least preferred.
Based on the results, “member” login is the most popular, followed by guest, with first signup and new being less common.*/
select Customer_Login_type, Count(Customer_Id) as TotalCustomers
from [E-commence-data-set]
GROUP BY Customer_Login_type
ORDER BY TotalCustomers desc;

-- How does the date and time affect my sales? (Total sales by month, the days of week or time arrival)
/*THIS QUERY calculates the most sold products in the year overtime and the output shows that the month of April has the 
highest effect on sales under the 'fashion' product category*/
SELECT Product,Product_Category, DATENAME(MONTH, Order_Date) AS Monthh, SUM(Sales) AS TotalSales
FROM [E-commence-data-set]
GROUP BY Product,Product_Category ,Order_Date,Sales
ORDER BY TotalSales DESC;

--From which product do I earn the most profit per unit?
/*To identify the most profitable products per unit,
this analysis calculates the total profit for each product and ranks them.
By summing up the profit for each product, we determine which ones contribute the most profit overall.
Grouping by product and ordering by total profit in descending order gives a ranked list of the top five most profitable products.
This approach helps pinpoint which products are most financially valuable to the business,
guiding strategies around inventory, marketing, or pricing.*/
select top 1 Product, sum(Profit) as MostProfitable 
from [E-commence-data-set]
group by Product
order by MostProfitable desc;

select top 5 Product, sum(Profit) as MostProfitable 
from [E-commence-data-set]
group by Product
order by MostProfitable desc;


--How is my delivery speed and order priority? (Delivery Time distribution of order priority by months)
/* To analyze delivery speed and order priority,
this approach examines the distribution of delivery times (using the aging column) by counting how often each delivery time appears.
Grouping by aging gives a view of different delivery speeds, while ordering by the count (or delivery speed) in descending order
highlights the most common delivery times.
By observing the count of aging values month by month,
you can determine if certain priorities or months experience faster or slower deliveries,
providing insight into patterns or areas to improve delivery efficiency.*/
select Order_Priority, Aging, count(Order_Priority) as frequency, count(Aging) as DeliverySpeed
from [E-commence-data-set]
group by Order_Priority, Aging
order by frequency Desc;

/*Calculate total sales for each month over the time period covered by the dataset*/
/*To calculate total sales for each month across the dataset’s timeframe,
this analysis sums up all sales for each month.
By extracting the month name from the order_date and summing the sales for each,
it gives the total sales for each month over time.
Grouping by month helps isolate monthly sales trends,
and ordering by total sales in descending order shows which months had the highest sales.
This approach provides a clear picture of monthly sales performance,
highlighting peak periods and helping with forecasting or seasonal strategy adjustments.*/
SELECT 
    Datename(Month, Order_Date) AS month, Datepart(Month, Order_Date) as MonthNo, SUM(Sales) AS total_sales
FROM 
    [E-commence-data-set]
GROUP BY  Datepart(Month, Order_Date), Datename(Month, Order_Date)
ORDER BY Datepart(Month, Order_Date) asc;

--Identify the month with the highest sales and analyze the factors contributing to the peak
/*The analysis highlights a peak sales month with high order counts and large quantities sold,
driven by factors such as customer demand, popular products, and likely discounts or seasonal events.
These elements contributed to the increased sales,
suggesting that targeted promotions or aligning with seasonal trends can be effective strategies.
Understanding these drivers allows for replicating similar tactics in other months to enhance future sales performance.*/
SELECT DATENAME(MONTH,Order_Date) as Month ,COUNT(Order_Date) AS NoOfOrders, SUM(Quantity) as Totalquantity
FROM [E-commence-data-set]
GROUP BY DATENAME(MONTH,Order_Date)
ORDER BY NoOfOrders DESC;


/*Determine the top 5 best-selling products based on the total quantity sold.*/
/*To identify the top 5 best-selling products based on quantity,
this approach calculates the total units sold for each product and ranks them.
By summing the quantity sold for each product, you get the overall demand per product.
Grouping by product and ordering by total quantity sold in descending order reveals the top performers,
with the highest-demand items ranked first.
This query shows which products are most popular, guiding decisions on inventory and marketing focus.*/
select top 5 Product, sum(Quantity) as TotalQuantity
from [E-commence-data-set]
GROUP by Product
Order by TotalQuantity desc;

--Provide insights into the characteristics of these products, such as price range, category, and sub-category
/*In summary, analyzing the price range, category, and subcategory of top-selling products
reveals customer preferences and demand patterns.
Understanding these characteristics allows for more targeted inventory,
pricing, and marketing strategies,ensuring the focus is on high-demand items that align with customer interests.
This approach supports better decision-making to drive sales and optimize product offerings.*/
SELECT Product_Category, min(sales) as MinSales, max(Sales) as MaxSales, AVG(Sales) as AvgSales
from [E-commence-data-set]
group by Product_Category
order by Product_Category;

/*Analyze total sales by product category to determine which categories contribute 
/*To analyze total sales by product category,
the process involves selecting the product_category and summing the sales from the dataset.
By grouping the results by product_category and ordering them by total sales in descending order,
We can identify which categories generated the highest sales contributions.
This query highlights key product categories, helping to focus strategies on areas
that drive the most revenue.*/
the most to revenue*/
select Product_Category, sum(Sales) as TotalSales
from [E-commence-data-set]
group by Product_Category
order by TotalSales desc;

--Calculate the percentage contribution of each category to the overall sales.
/*This query outcome will categorize products into “Discounted” and “Not Discounted” groups,
showing the total quantity sold for each.
This allows us to compare sales volumes between discounted and non-discounted items.
By observing the total quantities sold, one can also see if discounts correlate with higher sales volumes,
suggesting that discounts may boost purchase frequency.
Additionally, analyzing revenue for each group will help determine if discounted
products contribute significantly to total sales, or if non-discounted products still drive substantial
revenue without price reductions. This result informs pricing strategies by clarifying how
discounts impact sales performance and customer purchasing behavior.*/
ALTER TABLE [E-commence-data-set]
ALTER COLUMN Sales float

select Product_Category,
(
(sum(Sales))/(SELECT SUM(Sales) FROM [E-commence-data-set]))*100 AS SalesPercentage
FROM [E-commence-data-set]
GROUP BY Product_Category;

/*Calculate the average sales per order.*/
/*The outcome of this query shows the average sales per
order by product category, listing each category with its average sales amount in descending order.
This lets us see which product categories generate the highest average revenue per order,
highlighting those that are most profitable on a per-order basis and
helping to inform decisions around pricing and promotion strategies for each category.*/
SELECT Product_Category, AVG(Sales) AS AverageSales
FROM [E-commence-data-set]
GROUP BY Product_Category
ORDER BY AverageSales DESC;


--Identify the top 5 orders by total sales amount and analyze which products contributed the most to these orders.
/*The result of this query will display the top 5 orders based on total sales amount,
showing each order’s date and its total sales figure.
This highlights the highest-grossing orders.
By examining the products associated with these orders,
one can identify which items contributed the most to their high sales value.
This result reveals which products have the potential to drive large orders,
supporting inventory prioritization and targeted sales
strategies for these high-impact items.*/
select top 5 Product,Order_Date, Sales 
from [E-commence-data-set]
order by Sales DESC;

/*Analyze the impact of discounts on sales performance. Determine if products with 
discounts are sold more frequently or generate higher revenue than non-discounted 
products*/
/*This query outcome will categorize products into “Discounted” and “Not Discounted” groups,
showing the total quantity sold for each.
This allows us to compare sales volumes between discounted and non-discounted items.
By observing the total quantities sold, one can also see if discounts correlate with higher sales volumes,
suggesting that discounts may boost purchase frequency.
Additionally, analyzing revenue for each group will help determine if discounted
products contribute significantly to total sales, or if non-discounted products still drive substantial
revenue without price reductions. This result informs pricing strategies by clarifying how
discounts impact sales performance and customer purchasing behavior.*/
SELECT Product,
CASE WHEN Discount > 0 THEN 'DISCOUNTED'
ELSE 'NOT DISCOUNTED' END AS DiscountStats, COUNT(Quantity) AS TotalquantitySold
FROM [E-commence-data-set]
GROUP BY Product ,Discount;

--Provide recommendations on whether to continue offering discounts based on your findings.
/*Based on the findings, here are some recommendations on whether to continue offering discounts:

	1.	Increased Sales Frequency with Discounts: If discounted products were found to sell in higher quantities, offering
discounts could effectively boost sales volume, especially for categories or products with lower baseline sales.
This strategy would help increase customer engagement and turnover of specific items.

2.	Revenue Contribution of Discounted vs. Non-Discounted Products:
If discounts lead to increased frequency but result in lower total revenue compared to non-discounted products,
then discounts might be limited to promotional periods or slower-moving products.
For high-revenue products that perform well without discounts, maintaining standard
pricing can help maximize profits.

	3.	Category-Specific Insights: For product categories
that show strong performance with discounts, consider continuing or enhancing discounts to drive sales.
Conversely, for categories that maintain stable sales without discounts,
consider phasing out discounts or offering them sparingly to protect profit margins.

4.	Customer Loyalty and Engagement

5. ⁠drive repeat purchases, then maintaining occasional discounts may be beneficial to retain
customer interest. However, offering discounts too frequently could set customer
expectations, potentially reducing willingness to buy at full price.
Recommendation Summary

Continue offering discounts selectively—focusing on low-performing items or during strategic sales periods.
For high-demand or consistently profitable products, maintain regular pricing to protect margins. Use targeted,
time-limited discounts to maximize customer engagement without undermining overall revenue.*/
