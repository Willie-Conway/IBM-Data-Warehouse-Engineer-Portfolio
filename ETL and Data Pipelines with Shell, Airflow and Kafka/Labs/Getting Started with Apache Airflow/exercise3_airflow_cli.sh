#!/bin/bash
set -e  # exit on first error

# Initialise / upgrade Airflow metadata DB (safe to run repeatedly)
echo "Initialising Airflow metadata database..."
airflow db init   # or: airflow db upgrade
echo "----------------------------------------"

# Exercise 3 commands
echo "Listing all existing DAGs..."
airflow dags list
echo "----------------------------------------"

echo "Listing all tasks in DAG: example_bash_operator..."
airflow tasks list example_bash_operator
echo "----------------------------------------"

echo "Listing all tasks in DAG: tutorial..."
airflow tasks list tutorial
echo "----------------------------------------"

echo "Exercise 3 completed."



# To use it:

# Save the script:

# nano exercise3_airflow_cli.sh

# Paste the code above and save (CTRL+O, Enter, then CTRL+X).

# Make it executable:

# chmod +x exercise3_airflow_cli.sh

# Run it:

# ./exercise3_airflow_cli.sh