#!/usr/bin/env bash
# lab_run_all.sh
# IBM Skills Network lab automation (Kafka 3.7.0 KRaft + MySQL steps + files)
set -euo pipefail
cd /home/project || exit 1

echo "=== Exercise 1: Create airflow finalassignment folder and download data ==="
sudo mkdir -p /home/project/airflow/dags/finalassignment/staging
sudo chmod -R 777 /home/project/airflow/dags/finalassignment
sudo curl -sSL "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/tolldata.tgz" -o /home/project/airflow/dags/finalassignment/tolldata.tgz

echo "=== Exercise 2: Download & extract Kafka (3.7.0) ==="
wget -q https://archive.apache.org/dist/kafka/3.7.0/kafka_2.12-3.7.0.tgz -O kafka_2.12-3.7.0.tgz
tar -xzf kafka_2.12-3.7.0.tgz
cd kafka_2.12-3.7.0

echo "Generating KRaft cluster-id..."
export KAFKA_CLUSTER_ID="$(bin/kafka-storage.sh random-uuid)"
echo "KAFKA_CLUSTER_ID=$KAFKA_CLUSTER_ID"

echo "Formatting storage..."
bin/kafka-storage.sh format --cluster-id "$KAFKA_CLUSTER_ID" --config config/kraft/server.properties

echo "Starting Kafka server in background (KRaft)..."
nohup bin/kafka-server-start.sh config/kraft/server.properties > /home/project/kafka-server.log 2>&1 &
sleep 6
tail -n 40 /home/project/kafka-server.log || true

echo "=== Exercise 3: (MySQL step in Skills Network UI must be used) ==="
echo "Open the MySQL panel in the IDE as the lab instructs, copy the password and run:"
echo "mysql --host=mysql --port=3306 --user=root --password=YOUR_PASSWORD"
echo "Then: CREATE DATABASE tolldata; USE tolldata; CREATE TABLE livetolldata(timestamp DATETIME,vehicle_id INT,vehicle_type CHAR(15),toll_plaza_id SMALLINT);"

echo "=== Exercise 4: Install Python libs ==="
pip3 install --user kafka-python mysql-connector-python==8.0.31 >/dev/null

echo "=== Exercise 5: Create topic 'toll' and download generator/consumer ==="
cd /home/project
# create topic (bootstrap-server may be 9092 or 9093 depending on KRaft listeners - try 9093 then 9092)
if ! bin/kafka-topics.sh --bootstrap-server localhost:9093 --create --topic toll --partitions 1 --replication-factor 1 >/dev/null 2>&1; then
  bin/kafka-topics.sh --bootstrap-server localhost:9092 --create --topic toll --partitions 1 --replication-factor 1
fi

wget -q "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Final%20Assignment/toll_traffic_generator.py" -O /home/project/toll_traffic_generator.py
wget -q "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/vVxmU5uatDowvAIKRZrFjg/streaming-data-reader.py" -O /home/project/streaming-data-reader.py

echo "=== Lab replica setup DONE ==="
echo "To run producer (in new terminal):"
echo "  cd /home/project && python3 toll_traffic_generator.py"
echo "To run consumer (in new terminal), edit streaming-data-reader.py with DB credentials and run:"
echo "  cd /home/project && python3 streaming-data-reader.py"
echo ""
echo "IMPORTANT: For screenshots required by the course, use Airflow UI and the commands"
echo "airflow dags list, airflow dags list-import-errors, airflow dags unpause ETL_toll_data, airflow dags trigger ETL_toll_data"
