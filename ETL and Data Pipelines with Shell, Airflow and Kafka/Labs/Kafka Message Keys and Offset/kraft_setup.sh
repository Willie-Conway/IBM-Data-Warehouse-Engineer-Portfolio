#!/bin/bash

# Exercise 2: Configure KRaft and Start Server

# 1. Change to Kafka installation directory
cd kafka_2.13-3.8.0

# 2. Generate a unique Cluster UUID for the Kafka KRaft controller
KAFKA_CLUSTER_ID="$(bin/kafka-storage.sh random-uuid)"
echo "Generated Kafka Cluster ID: $KAFKA_CLUSTER_ID"

# 3. Format log directories using the generated Cluster ID
bin/kafka-storage.sh format -t $KAFKA_CLUSTER_ID -c config/kraft/server.properties

# 4. Start Kafka server in KRaft mode
bin/kafka-server-start.sh config/kraft/server.properties
