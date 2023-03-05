CREATE OR REPLACE VIEW orders_customers_employees AS
SELECT  order_date, required_date, shipped_date, ship_postal_code,
		company_name, contact_name, phone,
		last_name, first_name, title
FROM orders
JOIN customers USING (customer_id)
JOIN employees USING (employee_id);


SELECT *
FROM orders_customers_employees
WHERE order_date > '1997-01-01';

ALTER VIEW orders_customers_employees RENAME TO oce_old;


CREATE OR REPLACE VIEW orders_customers_employees AS
SELECT  order_date, required_date, shipped_date, ship_postal_code, ship_country,
		company_name, contact_name, phone,
		last_name, first_name, title, employees.postal_code, reports_to
FROM orders
JOIN customers USING (customer_id)
JOIN employees USING (employee_id);

SELECT *
FROM orders_customers_employees
WHERE order_date > '1997-01-01'
ORDER BY ship_country;

DROP VIEW oce_old;

CREATE OR REPLACE VIEW active_products AS
SELECT *
FROM products
WHERE discontinued <> 1
WITH LOCAL CHECK OPTION;

INSERT INTO active_products (product_name, discontinued)
VALUES
('Milk', 1);

SELECT *
FROM active_products;
