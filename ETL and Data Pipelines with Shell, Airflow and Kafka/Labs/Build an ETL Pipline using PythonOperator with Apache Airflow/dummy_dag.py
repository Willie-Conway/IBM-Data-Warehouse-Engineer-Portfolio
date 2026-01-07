# # Set the AIRFLOW_HOME directory.
# export AIRFLOW_HOME=/home/project/airflow

# # Submit a DAG by copying it into the Airflow dags folder.
# cp dummy_dag.py $AIRFLOW_HOME/dags

# # Verify that our DAG actually got submitted.
# airflow dags list

# # Verify that dummy_dag is a part of the output.
# airflow dags list | grep dummy_dag

# # List out all the tasks in dummy_dag.
# airflow tasks list dummy_dag
