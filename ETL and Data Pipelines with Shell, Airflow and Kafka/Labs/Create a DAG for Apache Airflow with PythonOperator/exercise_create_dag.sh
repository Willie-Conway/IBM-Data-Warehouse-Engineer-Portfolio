#!/bin/bash

# Set Airflow home directory
export AIRFLOW_HOME=/home/project/airflow
DAG_FILE="my_first_dag.py"
DAGS_DIR="$AIRFLOW_HOME/dags"

# Step 1: Create DAG Python file
echo "Creating DAG file: $DAG_FILE"

cat <<EOF > $DAG_FILE
from datetime import timedelta
from airflow.models import DAG
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago

input_file = '/etc/passwd'
extracted_file = 'extracted-data.txt'
transformed_file = 'transformed.txt'
output_file = 'data_for_analytics.csv'

def extract():
    with open(input_file, 'r') as infile, open(extracted_file, 'w') as outfile:
        for line in infile:
            fields = line.split(':')
            if len(fields) >= 6:
                outfile.write(f"{fields[0]}:{fields[2]}:{fields[5]}\\n")

def transform():
    with open(extracted_file, 'r') as infile, open(transformed_file, 'w') as outfile:
        for line in infile:
            outfile.write(line.replace(':', ',').strip() + '\\n')

def load():
    with open(transformed_file, 'r') as infile, open(output_file, 'w') as outfile:
        for line in infile:
            outfile.write(line.strip() + '\\n')

def check():
    with open(output_file, 'r') as infile:
        for line in infile:
            print(line.strip())

default_args = {
    'owner': 'Willie Conway',
    'start_date': days_ago(1),
    'email': ['hire.willie.conway@gmail.com'],
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

dag = DAG(
    'my-first-python-etl-dag',
    default_args=default_args,
    description='My first DAG',
    schedule_interval=timedelta(days=1),
)

execute_extract = PythonOperator(
    task_id='extract',
    python_callable=extract,
    dag=dag,
)

execute_transform = PythonOperator(
    task_id='transform',
    python_callable=transform,
    dag=dag,
)

execute_load = PythonOperator(
    task_id='load',
    python_callable=load,
    dag=dag,
)

execute_check = PythonOperator(
    task_id='check',
    python_callable=check,
    dag=dag,
)

execute_extract >> execute_transform >> execute_load >> execute_check
EOF

# Step 2: Move DAG file to Airflow DAGs directory
echo "Moving $DAG_FILE to $DAGS_DIR..."
mv $DAG_FILE $DAGS_DIR/

# Step 3: Initialize Airflow DB if needed
echo "Initializing Airflow database (airflow db init)..."
airflow db init

# Step 4: Verify DAG submission
echo "Verifying DAG is listed..."
airflow dags list | grep my-first-python-etl-dag

# Step 5: Check import errors if any
echo "Checking for DAG import errors..."
airflow dags list-import-errors

# Step 6: Start Airflow scheduler
echo "Starting Airflow scheduler in background..."
nohup airflow scheduler > scheduler.log 2>&1 &

# Step 7: Start Airflow webserver
echo "Starting Airflow webserver in background (default port 8080)..."
nohup airflow webserver > webserver.log 2>&1 &

echo "Setup complete. Access the Airflow UI at http://localhost:8080"





# To Run:

# Save this file:

# nano exercise_create_dag.sh

# Paste the code above, save (Ctrl+O, Enter), and exit (Ctrl+X).

# Make it executable:

# chmod +x exercise_create_dag.sh

# Run it:

# ./exercise_create_dag.sh
