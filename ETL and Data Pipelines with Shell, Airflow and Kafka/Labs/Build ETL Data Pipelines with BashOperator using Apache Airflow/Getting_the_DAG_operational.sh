#!/bin/bash

echo "=== Unpausing the DAG ==="
airflow dags unpause ETL_toll_data

echo "=== Triggering the DAG ==="
airflow dags trigger ETL_toll_data

echo "=== Listing all tasks in the DAG ==="
airflow tasks list ETL_toll_data

echo "=== Checking DAG run history ==="
airflow dags list-runs -d ETL_toll_data

echo "=== DONE: Your DAG is now running ==="


# 🎯 What this script does
# ✔ Unpauses the DAG

# So Airflow can run it.

# ✔ Triggers a manual DAG run

# Required for screenshots.

# ✔ Shows all tasks

# So you can capture dag_tasks.jpg.

# ✔ Shows all DAG run history

# So you can capture dag_runs.jpg.