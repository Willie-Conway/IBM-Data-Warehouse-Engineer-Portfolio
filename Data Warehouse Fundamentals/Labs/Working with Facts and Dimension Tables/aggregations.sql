-- Average billing per customer
SELECT customerid, AVG(billedamount) AS avg_billing
FROM "FactBilling"
GROUP BY customerid;

-- Billing by country
SELECT c.country, SUM(f.billedamount) AS total_billing
FROM "FactBilling" f
JOIN "DimCustomer" c ON f.customerid = c.customerid
GROUP BY c.country;
