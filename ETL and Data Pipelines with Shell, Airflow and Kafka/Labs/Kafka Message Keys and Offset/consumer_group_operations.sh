#!/bin/bash

# Exercise 5: Consumer offset operations
cd kafka_2.13-3.8.0

echo "=== Starting consumer in group atm-app ==="
bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --group atm-app

echo "=== Stop consumer, then checking consumer group details ==="
bin/kafka-consumer-groups.sh \
  --bootstrap-server localhost:9092 \
  --describe \
  --group atm-app

echo "=== Resetting offsets to earliest (beginning) ==="
bin/kafka-consumer-groups.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --group atm-app \
  --reset-offsets \
  --to-earliest \
  --execute

echo "=== Consuming ALL messages from the beginning ==="
bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --group atm-app

echo "=== Resetting offset to read ONLY last 2 messages per partition ==="
bin/kafka-consumer-groups.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --group atm-app \
  --reset-offsets \
  --shift-by -2 \
  --execute

echo "=== Consuming last 2 messages from each partition ==="
bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --group atm-app
