-- Provide stable interface for applications
CREATE VIEW CUSTOMER_ORDERS AS
SELECT 
    c.customer_id,
    c.name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
-- Even if underlying tables change, view remains stable