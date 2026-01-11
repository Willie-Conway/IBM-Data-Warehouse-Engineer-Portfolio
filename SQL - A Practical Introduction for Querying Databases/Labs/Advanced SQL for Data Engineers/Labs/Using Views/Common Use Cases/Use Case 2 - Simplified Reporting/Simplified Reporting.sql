-- Pre-calculate metrics for reports
CREATE VIEW MONTHLY_SALES_REPORT AS
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(amount) AS total_sales,
    COUNT(*) AS num_orders,
    AVG(amount) AS avg_order_value
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m');