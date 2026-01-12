#!/bin/sh

# Set PostgreSQL password
export PGPASSWORD="O1lkqKAiXdN88evrXy8ETMVo"

# Connect to PostgreSQL and create the database
psql --username=postgres --host=postgres -c "create database staging;"

# Connect to the new database and create tables
psql --username=postgres --host=postgres --dbname=staging -c "
DROP TABLE IF EXISTS sales_data CASCADE;
CREATE TABLE sales_data(
    rowid int,
    product_id int,
    customer_id int,
    price decimal(10,2),
    quantity int,
    timestamp timestamp
);

DROP TABLE IF EXISTS DimDate CASCADE;
CREATE TABLE DimDate(
    dateid SERIAL PRIMARY KEY,
    date DATE UNIQUE,
    year INT,
    month INT,
    day INT,
    quarter INT,
    dayofweek INT
);

DROP TABLE IF EXISTS FactSales CASCADE;
CREATE TABLE FactSales(
    salesid SERIAL PRIMARY KEY,
    dateid INT REFERENCES DimDate(dateid),
    product_id INT,
    customer_id INT,
    quantity INT,
    price DECIMAL(10,2),
    total_amount DECIMAL(10,2)
);"

echo "PostgreSQL staging database setup complete!"
unset PGPASSWORD