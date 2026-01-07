from datetime import timedelta
from airflow import DAG 
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago 
import requests
import tarfile
import csv
import os

# =====================
# PATHS & CONSTANTS
# =====================

source_url = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/tolldata.tgz"
staging_dir = "/home/project/airflow/dags/python_etl/staging"

# Ensure staging directory exists
os.makedirs(staging_dir, exist_ok=True)

# =====================
# PYTHON FUNCTIONS
# =====================

# =====================
# DOWNLOAD DATASET
# =====================

def download_dataset():
    """Download the dataset archive"""
    tgz_path = f"{staging_dir}/tolldata.tgz"
    print("Downloading dataset...")

    response = requests.get(source_url, stream=True)
    if response.status_code == 200:
        with open(tgz_path, "wb") as f:
            f.write(response.content)
        print("Download complete.")
    else:
        raise Exception("Failed to download dataset")

# =====================
# UNTAR DATASET
# =====================

def untar_dataset():
    """Extract downloaded .tgz file"""
    tgz_path = f"{staging_dir}/tolldata.tgz"
    print("Extracting dataset...")

    with tarfile.open(tgz_path, "r:gz") as tar:
        tar.extractall(path=staging_dir)

    print("Extraction complete.")

# ======================
# EXTRACT DATA FROM CSV
# ======================

def extract_data_from_csv():
    """Extract fields from vehicle-data.csv"""
    input_file = f"{staging_dir}/vehicle-data.csv"
    output_file = f"{staging_dir}/csv_data.csv"

    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        writer = csv.writer(outfile)
        writer.writerow(["Rowid", "Timestamp", "Anonymized Vehicle number", "Vehicle type"])

        for line in infile:
            row = line.strip().split(",")
            writer.writerow([row[0], row[1], row[2], row[3]])

    print("CSV extraction complete.")

# ======================
# EXTRACT DATA FROM TSV
# ======================

def extract_data_from_tsv():
    """Extract fields from tollplaza-data.tsv"""
    input_file = f"{staging_dir}/tollplaza-data.tsv"
    output_file = f"{staging_dir}/tsv_data.csv"

    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        writer = csv.writer(outfile)
        writer.writerow(["Number of axles", "Tollplaza id", "Tollplaza code"])

        for line in infile:
            row = line.strip().split("\t")
            writer.writerow([row[0], row[1], row[2]])

    print("TSV extraction complete.")

# =============================
# EXTRACT DATA FROM FIXED WIDTH
# =============================

def extract_data_from_fixed_width():
    """Extract fields from payment-data.txt"""
    input_file = f"{staging_dir}/payment-data.txt"
    output_file = f"{staging_dir}/fixed_width_data.csv"

    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        writer = csv.writer(outfile)
        writer.writerow(["Type of Payment code", "Vehicle Code"])

        for line in infile:
            pay_code = line[0:6].strip()
            vehicle_code = line[6:12].strip()
            writer.writerow([pay_code, vehicle_code])

    print("Fixed-width extraction complete.")

# ====================
# CONSOLIDATE DATA
# ====================

def consolidate_data():
    """Merge CSV, TSV, and fixed-width data into one file"""
    csv_file = f"{staging_dir}/csv_data.csv"
    tsv_file = f"{staging_dir}/tsv_data.csv"
    fixed_width_file = f"{staging_dir}/fixed_width_data.csv"
    output_file = f"{staging_dir}/extracted_data.csv"

    with open(csv_file, "r") as f1, open(tsv_file, "r") as f2, open(fixed_width_file, "r") as f3, open(output_file, "w") as out:
        csv_reader = csv.reader(f1)
        tsv_reader = csv.reader(f2)
        fixed_reader = csv.reader(f3)
        writer = csv.writer(out)

        writer.writerow([
            "Rowid", "Timestamp", "Anonymized Vehicle number", "Vehicle type",
            "Number of axles", "Tollplaza id", "Tollplaza code",
            "Type of Payment code", "Vehicle Code"
        ])

        next(csv_reader)
        next(tsv_reader)
        next(fixed_reader)

        for c, t, f in zip(csv_reader, tsv_reader, fixed_reader):
            writer.writerow(c + t + f)

    print("Data consolidation complete.")

# ===================
# TRANSFORM DATA
# ===================

def transform_data():
    """Transform vehicle_type field to uppercase"""
    input_file = f"{staging_dir}/extracted_data.csv"
    output_file = f"{staging_dir}/transformed_data.csv"

    with open(input_file, "r") as infile, open(output_file, "w") as outfile:
        reader = csv.DictReader(infile)
        writer = csv.DictWriter(outfile, fieldnames=reader.fieldnames)
        writer.writeheader()

        for row in reader:
            row["Vehicle type"] = row["Vehicle type"].upper()
            writer.writerow(row)

    print("Data transformation complete.")

# =====================
# DAG CONFIG
# =====================

default_args = {
    "owner": "willie conway",
    "start_date": days_ago(0),
    "email": ["hire.willie.conway@example.com"],
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

dag = DAG(
    "ETL_toll_data",
    default_args=default_args,
    description="Apache Airflow Final Assignment - ETL Pipeline",
    schedule_interval=timedelta(days=1),
)

# =====================
# TASK DEFINITIONS
# =====================

download_task = PythonOperator(task_id="download_dataset", python_callable=download_dataset, dag=dag)
untar_task = PythonOperator(task_id="untar_dataset", python_callable=untar_dataset, dag=dag)
extract_csv_task = PythonOperator(task_id="extract_data_from_csv", python_callable=extract_data_from_csv, dag=dag)
extract_tsv_task = PythonOperator(task_id="extract_data_from_tsv", python_callable=extract_data_from_tsv, dag=dag)
extract_fixed_width_task = PythonOperator(task_id="extract_data_from_fixed_width", python_callable=extract_data_from_fixed_width, dag=dag)
consolidate_task = PythonOperator(task_id="consolidate_data", python_callable=consolidate_data, dag=dag)
transform_task = PythonOperator(task_id="transform_data", python_callable=transform_data, dag=dag)

# =====================
# TASK DEPENDENCIES
# =====================

download_task >> untar_task >> [extract_csv_task, extract_tsv_task, extract_fixed_width_task] >> consolidate_task >> transform_task


# ✅ NEXT STEPS 

# Run these in terminal:

# export AIRFLOW_HOME=/home/project/airflow
# cp ETL_toll_data.py $AIRFLOW_HOME/dags/
# airflow dags list | grep ETL_toll_data


# Then:

# airflow tasks list ETL_toll_data


# Finally open the UI:

# Unpause DAG

# Trigger DAG

# Watch all 7 tasks turn green