#!/bin/bash

echo "Exercise 4 - Create a Table in PostgreSQL"

echo -e "\nStep 1: Connect to the default PostgreSQL database 'template1' from the psql prompt:"
echo "postgres=# \\c template1"

echo -e "\nExpected Output:"
echo "You are now connected to database \"template1\" as user \"postgres\"."
echo "Prompt changes to: template1=#"

echo -e "\nStep 2: Create a table named 'users' with the following columns:"
echo "- username (varchar(50))"
echo "- userid (int)"
echo "- homedirectory (varchar(100))"

echo -e "\nRun this SQL command:"
echo "template1=# create table users(username varchar(50), userid int, homedirectory varchar(100));"

echo -e "\nExpected Output:"
echo "CREATE TABLE"

echo -e "\n✔️ The 'users' table has now been created successfully in the 'template1' database."
