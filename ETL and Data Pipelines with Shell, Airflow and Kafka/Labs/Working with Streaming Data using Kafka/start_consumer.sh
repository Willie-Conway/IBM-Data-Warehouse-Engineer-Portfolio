#!/bin/bash

# Exercise 4: Start Consumer for Kafka topic "news"

# 1. Navigate to Kafka directory
cd kafka_2.13-3.8.0 || {
  echo "Error: Kafka directory not found!"
  exit 1
}

echo "=== Kafka Directory Loaded ==="

# 2. Start the consumer for the 'news' topic
echo "=== Starting Consumer for topic: news ==="
echo "Listening for messages... (CTRL+C to exit)"

bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic news \
  --from-beginning



# ✅ How to Use

# 1. Create the script
# nano start_consumer.sh



# 2. Make it executable
# chmod +x start_consumer.sh


# 3. Run it
# ./start_consumer.sh


# You will now see all messages sent from the producer.