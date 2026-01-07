#!/bin/bash

echo "=== Setting AIRFLOW_HOME ==="
export AIRFLOW_HOME=/home/project/airflow
echo "AIRFLOW_HOME set to: $AIRFLOW_HOME"
echo

echo "=== Submitting dummy_dag.py to Airflow ==="
cp dummy_dag.py $AIRFLOW_HOME/dags
echo "dummy_dag.py copied to $AIRFLOW_HOME/dags"
echo

echo "=== Listing all DAGs ==="
airflow dags list
echo

echo "=== Checking if dummy_dag is registered ==="
airflow dags list | grep dummy_dag
echo

echo "=== Listing tasks inside dummy_dag ==="
airflow tasks list dummy_dag
echo

echo "=== Done! Your DAG has been submitted and verified. ==="
