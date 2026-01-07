#!/bin/bash

# Exercise 4: Pause or Unpause a DAG

echo "Unpausing DAG: tutorial"
airflow dags unpause tutorial
echo "----------------------------------------"

echo "Pausing DAG: tutorial"
airflow dags pause tutorial
echo "----------------------------------------"

echo "Unpausing DAG: example_branch_operator (Practice Exercise)"
airflow dags unpause example_branch_operator
echo "----------------------------------------"

echo "Current status of 'tutorial' DAG:"
airflow dags list | grep tutorial
echo "----------------------------------------"

echo "Current status of 'example_branch_operator' DAG:"
airflow dags list | grep example_branch_operator
echo "----------------------------------------"

echo "Exercise 4 completed."



# How to use:

# Create the script file:

# nano exercise4_pause_unpause_dag.sh

# Paste the code and save it (CTRL+O, Enter, then CTRL+X).

# Make it executable:

# chmod +x exercise4_pause_unpause_dag.sh

# Run it:

# ./exercise4_pause_unpause_dag.sh