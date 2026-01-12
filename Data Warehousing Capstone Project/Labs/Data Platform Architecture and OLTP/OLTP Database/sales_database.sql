CREATE DATABASE sales;

USE sales;

CREATE TABLE sales_data (
    product_id INT NOT NULL,
    customer_id INT NOT NULL, 
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    timestamp DATETIME NOT NULL,
    PRIMARY KEY (product_id, customer_id, timestamp)
);
