
# Insights Derived from SQL Queries

## 1. High-Value Orders

-- **Question:**

-- Q.1: Retrieve customers who placed orders with amounts greater than 150, including their names, email addresses, and the number of such orders.

SELECT 
    c.First_Name, 
    c.Email, 
    o.Order_Amount,
    COUNT(o.Order_ID) AS No_of_Orders
FROM 
    Customers AS c
INNER JOIN 
    Orders AS o ON c.Customer_ID = o.Customer_ID
WHERE 
    o.Order_Amount > 150
GROUP BY 
    c.Customer_ID, c.First_Name, c.Email, o.Order_Amount;

-- Insight:
Identifies customers who frequently place high-value orders. Provides their names, email addresses, and the amount of their order along with the count of such orders.
Use Case: Useful for targeting high-value customers with loyalty programs or special offers.




2. Orders in 2023
Question:

-- Q.2: Retrieve all orders from the year 2023, ordered by the order amount in descending order.
SELECT 
    customer_id,
    order_date,
    order_amount 
FROM 
    orders 
WHERE 
    YEAR(order_date) = 2023 
ORDER BY 
    order_amount DESC;
    
--Insight:

Provides a list of orders from 2023, sorted by the amount spent. Helps to understand high-value transactions within the year.
Use Case: Helps in analyzing yearly sales performance and prioritizing high-value transactions.




3. Average Order Amount by City
Question:

-- Q.3: Calculate the average order amount for each city.
SELECT 
    CITY,
    AVG(ORDER_AMOUNT) AS AVG_AMOUNT
FROM 
    CUSTOMERS 
INNER JOIN 
    ORDERS 
ON 
    CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID 
GROUP BY 
    CITY;
Insight:
Shows the average order amount per city. Helps identify cities with higher spending per order.
Use Case: Useful for targeted marketing and resource allocation based on city performance.




4. Top 5 Customers by Spending
Question:

-- Q.4: Retrieve the top 5 customers based on total spending.
SELECT 
    C.CUSTOMER_ID,
    C.FIRST_NAME,
    C.LAST_NAME,
    SUM(O.ORDER_AMOUNT) AS TOTAL_SPENT
FROM 
    CUSTOMERS AS C 
INNER JOIN 
    ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY 
    C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME 
ORDER BY 
    TOTAL_SPENT DESC 
LIMIT 5;

Insight:
Lists the top 5 customers based on total spending. Helps identify high-value customers.
Use Case: Useful for loyalty programs and personalized marketing strategies.




5. Orders with Missing Order IDs
Question:

-- Q.5: Check for any orders with missing order IDs (should return no results if all orders have IDs).
SELECT 
    C.CUSTOMER_ID,
    C.FIRST_NAME,
    C.LAST_NAME,
    O.ORDER_ID 
FROM 
    CUSTOMERS AS C 
INNER JOIN 
    ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID 
WHERE 
    O.ORDER_ID IS NULL;

Insight:
Ensures that all orders have valid IDs. Validates data integrity.
Use Case: Ensures the completeness and reliability of the order data.




6. Highest Order Amount for Each Customer
Question:

-- Q.6: Retrieve the highest order amount for each customer, including the corresponding order ID.
SELECT 
    c.Customer_ID,
    o.Order_Amount AS Highest_Amount,
    o.Order_ID
FROM 
    Customers AS c
INNER JOIN 
    Orders AS o 
    ON c.Customer_ID = o.Customer_ID
WHERE 
    o.Order_Amount = (
        SELECT 
            MAX(Order_Amount)
        FROM 
            Orders
        WHERE 
            Customer_ID = o.Customer_ID
    );
    
Insight:
Provides the maximum amount spent by each customer and the corresponding order ID.
Use Case: Useful for understanding the maximum spend behavior of customers.



7. Highest Selling Month in 2024
Question:
-- Q.7: Identify the month with the highest total sales amount in 2024.
SELECT 
    MONTH(ORDER_DATE) AS Month,
    SUM(ORDER_AMOUNT) AS High_Selling_Month
FROM 
    ORDERS
WHERE 
    YEAR(ORDER_DATE) = 2024
GROUP BY 
    MONTH(ORDER_DATE)
ORDER BY 
    High_Selling_Month DESC
LIMIT 1;

Insight:
Identifies the month with the highest total sales in 2024. Helps understand seasonal sales trends.
Use Case: Assists in inventory management and planning marketing campaigns based on seasonal trends.



8. Update Order Status
Question:

-- Q.8: Update the status of orders older than 30 days to "COMPLETED".
UPDATE 
    ORDERS 
SET 
    ORDER_STATUS = 'COMPLETED' 
WHERE 
    ORDER_DATE < CURDATE() - INTERVAL 30 DAY;
Insight:

Updates the status of older orders to "COMPLETED". Ensures order statuses are current.
Use Case: Helps in managing and tracking order fulfillment status.



9. Customer Order Summary View
Question:

-- Q.9: Create a view summarizing the total number of orders and total spending per customer.
CREATE VIEW CustomerOrderSummary AS
SELECT 
    customer_id,
    COUNT(order_id) AS Total_orders,
    SUM(order_amount) AS Total_spending 
FROM 
    orders
GROUP BY 
    customer_id;

-- Display the view
SELECT * FROM CustomerOrderSummary;
Insight:

Creates a view to quickly access customer order summaries including total orders and spending.
Use Case: Useful for generating summary reports and quick access to customer spending data.