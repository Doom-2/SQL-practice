-- output category names and total cost of products included in them with the status 'not discontinued',
-- make a post-filter where this cost is more than 5000 units
-- and sort them in descending order by the calculated cost
SELECT cat.category_name, ROUND(SUM(units_in_stock * unit_price)) AS total_cost
FROM products
INNER JOIN categories as cat ON products.category_id = cat.category_id
WHERE discontinued <> 1
GROUP BY cat.category_name
HAVING SUM(units_in_stock * unit_price) > 5000
ORDER BY total_cost DESC

-- Find customers and employees processing their orders,
-- where they are  both from the city of London
-- and shipping company is 'Speedy Express'. 
-- Output the customer's company name and the employee's full name.
SELECT customers.company_name, employees.last_name, employees.first_name
FROM orders
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN customers USING(customer_id)
INNER JOIN shippers ON orders.ship_via = shippers.shipper_id
WHERE shippers.company_name = 'Speedy Express' AND customers.city = 'London' AND employees.city = 'London';

-- Find active ('discontinued' field is not 1) products
-- from the 'Beverages' and 'Seafood' category,
-- that are less than 20 items on sale.
-- Output fields are:
-- product name
-- units in stock
-- supplier contact name
-- supplier phone number
SELECT product_name, units_in_stock, sup.contact_name, sup.phone
FROM products prod
JOIN suppliers AS sup ON prod.supplier_id = sup.supplier_id
JOIN categories USING(category_id)
WHERE discontinued <> 1 AND category_name IN ('Beverages', 'Seafood') AND units_in_stock < 20;


-- Find customers who have not arranged any orders.
-- Output the customer name and order_id.
-- Tip: use OUTER JOIN to solve the task.
SELECT customers.company_name, orders.order_id
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.customer_id
WHERE order_id IS NULL;

SELECT customers.company_name, orders.order_id
FROM orders
RIGHT JOIN customers ON orders.customer_id = customers.customer_id
WHERE order_id IS NULL;
