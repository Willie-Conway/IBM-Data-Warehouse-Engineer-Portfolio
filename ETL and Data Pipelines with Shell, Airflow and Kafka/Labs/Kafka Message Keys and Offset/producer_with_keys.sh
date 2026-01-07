#!/bin/bash

# Exercise 4: Produce messages with keys

# 1. Change to Kafka directory
cd kafka_2.13-3.8.0

# 2. Start producer with message key support
bin/kafka-console-producer.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --property parse.key=true \
  --property key.separator=: <<EOF
1:{"atmid": 1, "transid": 103}
1:{"atmid": 1, "transid": 104}
2:{"atmid": 2, "transid": 202}
2:{"atmid": 2, "transid": 203}
1:{"atmid": 1, "transid": 105}
EOF
