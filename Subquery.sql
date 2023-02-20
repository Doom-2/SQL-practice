-- Output products whose quantity in stock is less than
-- the smallest average one in the 'order_details' table (group by 'product_id').
-- The resulting table should have the 'product_name' and 'units_in_stock' columns.
SELECT DISTINCT product_name, units_in_stock
FROM products
         JOIN order_details USING (product_id)
WHERE units_in_stock < ALL (SELECT AVG(quantity)
                            FROM order_details
                            GROUP BY product_id)
ORDER BY units_in_stock DESC;

-- Get selection of the total orders' freight, grouped by customers,
-- where shipped date is in the 2nd half of July,
-- order selection by total freight.
SELECT customer_id, SUM(freight) AS total_freight
FROM orders
         LEFT JOIN (
-- 			get the average order's freight, grouped by customers
    SELECT customer_id, AVG(freight) AS avg_freight
    FROM orders
    GROUP BY customer_id) AS o_avg USING (customer_id)
WHERE freight > avg_freight
  AND shipped_date BETWEEN '1996-07-16' AND '1996-07-31'
GROUP BY customer_id
ORDER BY total_freight;

-- Get the order price as a result of multiplying the unit price by the quantity, including the discount.
-- Conditions: orders were created after and including September 1, 1997
-- and delivered to Latin American countries.
-- Limit results to 3 entries in descending order of the calculated order price.
SELECT customer_id,
       ship_country,
       order_price
FROM orders
         JOIN (SELECT order_id,
                      ROUND(SUM(unit_price * quantity - unit_price * quantity * discount)::Decimal, 2) AS order_price
               FROM order_details
               GROUP BY order_id) AS o_det
              USING (order_id)
WHERE order_date > '1997-09-01'
  AND ship_country IN (
                       'Argentina', 'Bolivia', 'Brazil', 'Chile', 'Colombia', 'Ecuador',
                       'Guyana', 'Paraguay', 'Peru', 'Suriname', 'Uruguay', 'Venezuela'
    )
ORDER BY order_price DESC LIMIT 3;

-- Output all products with a unique name of which exactly 10 units have been ordered.
-- Note: use subquery instead of JOIN
SELECT DISTINCT product_name
FROM products
WHERE product_id = ANY (SELECT product_id
                        FROM order_details
                        WHERE quantity = 10);
