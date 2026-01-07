# Step 1: Set your Airflow home directory
export AIRFLOW_HOME=/home/project/airflow
echo "AIRFLOW_HOME is set to: $AIRFLOW_HOME"

# Step 2: Submit your DAG by copying the DAG Python file to the Airflow DAGs folder
cp my_first_dag.py $AIRFLOW_HOME/dags
echo "DAG submitted: my_first_dag.py has been copied to $AIRFLOW_HOME/dags"

# Step 3: List all DAGs to verify it was added successfully
echo "Listing all registered DAGs..."
airflow dags list

# Optional: Confirm your DAG is in the list by filtering with grep
echo "Searching for your DAG in the list..."
airflow dags list | grep "my-first-python-etl-dag"

# Step 4: List tasks in your DAG
echo "Listing tasks in your DAG..."
airflow tasks list my-first-python-etl-dag


