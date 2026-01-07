#!/bin/bash

# Set the AIRFLOW_HOME environment variable
export AIRFLOW_HOME=/home/project/airflow
echo "AIRFLOW_HOME set to $AIRFLOW_HOME"

# Copy the DAG to the dags folder
cp my_first_dag.py $AIRFLOW_HOME/dags
echo "DAG file copied to $AIRFLOW_HOME/dags"

# List all DAGs
echo "Listing all DAGs..."
airflow dags list

# Verify that the DAG is present
echo "Verifying that 'my-first-python-etl-dag' is in the DAG list..."
airflow dags list | grep "my-first-python-etl-dag"

# List all tasks in the DAG
echo "Listing all tasks in 'my-first-python-etl-dag'..."
airflow tasks list my-first-python-etl-dag

echo "✅ DAG submission complete."



# Instructions to run:

# Make sure your DAG file my_first_dag.py exists in your current directory.

# Save the script above as submit_dag.sh.

# Give it execute permission:

# chmod +x submit_dag.sh

# Run the script:

# ./submit_dag.sh