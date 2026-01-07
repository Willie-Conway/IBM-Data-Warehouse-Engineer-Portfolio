#!/bin/bash

echo "===== Exercise 1: Setting up Airflow Lab Environment ====="

echo ">> Starting Apache Airflow..."
# Adjust to your environment if needed
airflow standalone &
sleep 5

echo ">> Creating directory structure..."
sudo mkdir -p /home/project/airflow/dags/finalassignment/staging

echo ">> Setting permissions..."
sudo chmod -R 777 /home/project/airflow/dags/finalassignment

echo ">> Downloading dataset (tolldata.tgz)..."
sudo curl https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/tolldata.tgz \
    -o /home/project/airflow/dags/finalassignment/tolldata.tgz

echo "===== Setup Complete! ====="
echo "Dataset saved to: /home/project/airflow/dags/finalassignment/tolldata.tgz"
echo "Staging directory: /home/project/airflow/dags/finalassignment/staging"



# ✅ How to Run It

# Save as:

# setup_airflow_env.sh


# Make executable:

# chmod +x setup_airflow_env.sh


# Run:

# ./setup_airflow_env.sh