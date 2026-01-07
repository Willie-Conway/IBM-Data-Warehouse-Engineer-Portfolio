#!/bin/bash

# Exercise 2: Configure KRaft and start server

# 1. Navigate to Kafka directory
cd kafka_2.13-3.8.0 || {
  echo "Kafka directory not found!"
  exit 1
}

echo "=== Kafka Directory Loaded ==="

# 2. Generate a unique KRaft cluster ID
KAFKA_CLUSTER_ID="$(bin/kafka-storage.sh random-uuid)"
echo "Generated Cluster ID: $KAFKA_CLUSTER_ID"

# 3. Format log directories with cluster ID (KRaft requirement)
echo "=== Formatting KRaft Storage ==="
bin/kafka-storage.sh format \
  -t "$KAFKA_CLUSTER_ID" \
  -c config/kraft/server.properties

# 4. Start Kafka server
echo "=== Starting Kafka Server ==="
bin/kafka-server-start.sh config/kraft/server.properties


# ✅ How to use it

# 1. Create the script

# nano start_kraft.sh


# 2. Make it executable

# chmod +x start_kraft.sh

# 3. Run it

# ./start_kraft.sh