#!/bin/bash

# Practice Exercise: Apache Airflow CLI for example_branch_labels

echo "Listing all tasks for DAG: example_branch_labels"
airflow tasks list example_branch_labels
echo "----------------------------------------"

echo "Unpausing DAG: example_branch_labels"
airflow dags unpause example_branch_labels
echo "----------------------------------------"

echo "Checking DAG status after unpause:"
airflow dags list | grep example_branch_labels
echo "----------------------------------------"

echo "Pausing DAG: example_branch_labels"
airflow dags pause example_branch_labels
echo "----------------------------------------"

echo "Checking DAG status after pause:"
airflow dags list | grep example_branch_labels
echo "----------------------------------------"

echo "Practice Exercise completed."



# Instructions to Run

# Open terminal in your Airflow environment.

# Create the script file:

# nano exercise_practice_example_branch_labels.sh

# Paste the code above and save it (CTRL+O, Enter, then CTRL+X).

# Make it executable:


# chmod +x exercise_practice_example_branch_labels.sh

# Run it:

# ./exercise_practice_example_branch_labels.sh