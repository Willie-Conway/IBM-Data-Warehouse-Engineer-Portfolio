#!/bin/bash

echo "==========================================="
echo "        Kafka Practice Exercises"
echo "==========================================="

# 1. Navigate to Kafka directory
cd kafka_2.13-3.8.0 || {
  echo "Error: Kafka directory not found!"
  exit 1
}

echo ""
echo "=== Step 1: Create topic 'weather' ==="
echo "Running: bin/kafka-topics.sh --create --topic weather --bootstrap-server localhost:9092"
bin/kafka-topics.sh --create --topic weather --bootstrap-server localhost:9092
echo ""


echo "=== Step 2: Start Kafka Producer for 'weather' topic ==="
echo "To start the producer, run this manually in another terminal:"
echo ""
echo "   bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic weather"
echo ""
echo "After the '>' prompt appears, type messages such as:"
echo "   Sunny"
echo "   Cloudy"
echo "   Storm approaching"
echo ""


echo "=== Step 3: Start Kafka Consumer for 'weather' topic ==="
echo "To start the consumer, run this manually in a NEW terminal:"
echo ""
echo "   bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic weather"
echo ""
echo "You should see all the messages you typed in the producer."
echo ""


echo "==========================================="
echo " Practice Exercise Setup Complete"
echo "==========================================="



# ✅ How to Use

# 1. Create the script:
# nano practice_exercises.sh



# 2. Make it executable:
# chmod +x practice_exercises.sh


# 3. Run it:
# ./practice_exercises.sh