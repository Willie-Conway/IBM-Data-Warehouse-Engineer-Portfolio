#!/bin/bash

# Exercise 3: Create a topic and start producer

# 1. Navigate to Kafka directory
cd kafka_2.13-3.8.0 || {
  echo "Error: Kafka directory not found!"
  exit 1
}

echo "=== Kafka Directory Loaded ==="

# 2. Create the 'news' topic
echo "=== Creating topic: news ==="
bin/kafka-topics.sh --create \
  --topic news \
  --bootstrap-server localhost:9092

echo "Topic 'news' created."

# 3. Start the Kafka producer for the 'news' topic
echo "=== Starting Producer for topic: news ==="
echo "Type your messages below. Press CTRL+C to exit."

bin/kafka-console-producer.sh \
  --bootstrap-server localhost:9092 \
  --topic news




# ✅ How to Use

# 1. Create the script
# nano create_topic_and_producer.sh




# 2. Make it executable
# chmod +x create_topic_and_producer.sh


# 3. Run it
# ./create_topic_and_producer.sh


# Producer will start and show:

# >


# You can then paste:

# Good morning
# Good day
# Enjoy the Kafka lab
