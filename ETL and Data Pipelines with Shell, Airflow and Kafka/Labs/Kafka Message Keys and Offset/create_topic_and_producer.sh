#!/bin/bash

# Exercise 3: Create a topic and producer for bank ATM transactions

# 1. Change to Kafka directory
cd kafka_2.13-3.8.0

# 2. Create the 'bankbranch' topic with 2 partitions
bin/kafka-topics.sh --create \
  --topic bankbranch \
  --partitions 2 \
  --bootstrap-server localhost:9092

# 3. List all topics
bin/kafka-topics.sh --bootstrap-server localhost:9092 --list

# 4. Describe topic details
bin/kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic bankbranch

# 5. Start a producer and automatically send ATM JSON messages
bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic bankbranch <<EOF
{"atmid": 1, "transid": 100}
{"atmid": 1, "transid": 101}
{"atmid": 2, "transid": 200}
{"atmid": 1, "transid": 102}
{"atmid": 2, "transid": 201}
EOF
