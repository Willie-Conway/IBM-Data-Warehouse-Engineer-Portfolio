from airflow import DAG 
from airflow.operators.bash import BashOperator 
from datetime import datetime, timedelta

# -----------------------------
# DAG Arguments
# -----------------------------
default_args = {
    'owner': 'willie conway',                     # dummy name
    'start_date': datetime.now(),          # today
    'email': ['hire.willie.conway@gmail.com'],        # dummy email
    'email_on_failure': True,
    'email_on_retry': True,
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

# -----------------------------
# DAG Definition
# -----------------------------
dag = DAG(
    dag_id='ETL_toll_data',
    default_args=default_args,
    description='Apache Airflow Final Assignment',
    schedule_interval='@daily',
)

# -----------------------------
# Task 1 — Unzip data
# -----------------------------
unzip_data = BashOperator(
    task_id='unzip_data',
    bash_command="""
    cd /home/project/airflow/dags/finalassignment &&
    tar -xf tolldata.tgz
    """,
    dag=dag,
)

# -----------------------------
# Task 2 — Extract CSV Data
# Rowid, Timestamp, Anonymized Vehicle number, Vehicle type
# -----------------------------
extract_data_from_csv = BashOperator(
    task_id='extract_data_from_csv',
    bash_command="""
    cd /home/project/airflow/dags/finalassignment &&
    cut -d"," -f1,2,3,4 vehicle-data.csv > csv_data.csv
    """,
    dag=dag,
)

# -----------------------------
# Task 3 — Extract TSV Data
# Number of axles, Tollplaza id, Tollplaza code
# -----------------------------
extract_data_from_tsv = BashOperator(
    task_id='extract_data_from_tsv',
    bash_command="""
    cd /home/project/airflow/dags/finalassignment &&
    cut -f2,3,4 tollplaza-data.tsv > tsv_data.csv
    """,
    dag=dag,
)

# -----------------------------
# Task 4 — Extract Fixed Width Data
# Type of Payment code, Vehicle Code
# -----------------------------
extract_data_from_fixed_width = BashOperator(
    task_id='extract_data_from_fixed_width',
    bash_command="""
    cd /home/project/airflow/dags/finalassignment &&
    awk '{print substr($0,1,6), substr($0,7,10)}' payment-data.txt > fixed_width_data.csv
    """,
    dag=dag,
)

# -----------------------------
# Task 5 — Consolidate Data
# Combine csv_data.csv + tsv_data.csv + fixed_width_data.csv
# -----------------------------
consolidate_data = BashOperator(
    task_id='consolidate_data',
    bash_command="""
    cd /home/project/airflow/dags/finalassignment &&
    paste -d"," csv_data.csv tsv_data.csv fixed_width_data.csv > extracted_data.csv
    """,
    dag=dag,
)

# -----------------------------
# Task 6 — Transform Data
# Convert vehicle_type field to uppercase
# -----------------------------
transform_data = BashOperator(
    task_id='transform_data',
    bash_command="""
    cd /home/project/airflow/dags/finalassignment &&
    awk -F',' 'BEGIN{OFS=","} {$4=toupper($4)}1' extracted_data.csv \
    > staging/transformed_data.csv
    """,
    dag=dag,
)

# -----------------------------
# Task Pipeline (Dependencies)
# -----------------------------
unzip_data >> extract_data_from_csv >> extract_data_from_tsv >> extract_data_from_fixed_width >> consolidate_data >> transform_data
