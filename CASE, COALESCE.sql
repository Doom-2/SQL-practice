-- Aux query
INSERT INTO customers(customer_id, contact_name, city, country, company_name)
VALUES
('AAAAA', 'Alfred Mann', NULL, 'USA', 'fake_company'),
('BBBBB', 'Alfred Mann', NULL, 'Austria','fake_company');

-- Select 'contact_name', 'city', 'country', order by 'contact_name' and 'city' if city is not null
-- else order by 'contact_name' and 'country'
SELECT contact_name, city, country
FROM customers
ORDER BY contact_name,
	CASE WHEN city IS NOT NULL THEN city
	 	 ELSE country
	END;

-- Description in decision
SELECT product_name, unit_price,
CASE WHEN unit_price >= 100 THEN 'too expensive'
	 WHEN unit_price >= 50 AND units_in_stock < 100 THEN 'average'
	 ELSE 'low price'
END AS amount
FROM products;

-- Find customers which did no do any order.
-- Output 'contact_name' and 'no orders' if 'order_id' = NULL
-- Tip: use LEFT JOIN on 'orders' table to find customers who are not referenced from the 'orders' table
SELECT contact_name, COALESCE(order_id::text, 'no orders') as order_id
FROM customers
LEFT JOIN orders USING (customer_id)
WHERE order_id IS NULL;

-- Output the full name of employees and their 'title'.
-- If the title is 'Sales Representative' output 'Sales Stuff' instead
SELECT first_name, last_name, COALESCE(NULLIF(title, 'Sales Representative'), 'Sales Stuff') as title
FROM employees;
