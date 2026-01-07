import os, json, time
from kafka import KafkaConsumer # type: ignore
import mysql.connector

broker = os.environ.get("KAFKA_BROKER","kafka:9092")
topic = os.environ.get("TOPIC","toll")
mysql_host = os.environ.get("MYSQL_HOST","mysql")
mysql_port = int(os.environ.get("MYSQL_PORT",3306))
mysql_db = os.environ.get("MYSQL_DB","tolldata")
mysql_user = os.environ.get("MYSQL_USER","root")
mysql_pass = os.environ.get("MYSQL_PASS","changeme")

consumer = KafkaConsumer(topic, bootstrap_servers=[broker],
                         value_deserializer=lambda m: json.loads(m.decode('utf-8')),
                         auto_offset_reset='earliest', enable_auto_commit=True)

# wait for MySQL to be ready
time.sleep(5)

conn = mysql.connector.connect(host=mysql_host, port=mysql_port, user=mysql_user, password=mysql_pass, database=mysql_db)
cursor = conn.cursor()
cursor.execute("""
CREATE TABLE IF NOT EXISTS livetolldata (
  timestamp DATETIME,
  vehicle_id INT,
  vehicle_type VARCHAR(50),
  toll_plaza_id SMALLINT
);
""")
conn.commit()

for msg in consumer:
    v = msg.value
    ts = v.get("timestamp")
    vid = int(v.get("vehicle_id"))
    vtype = v.get("vehicle_type")
    plaza = int(v.get("toll_plaza_id"))
    cursor.execute("INSERT INTO livetolldata (timestamp,vehicle_id,vehicle_type,toll_plaza_id) VALUES (%s,%s,%s,%s)", (ts,vid,vtype,plaza))
    conn.commit()
    print("inserted", v)
