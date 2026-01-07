#!/bin/bash

# Exercise 5: Produce additional messages for offset changes
cd kafka_2.13-3.8.0

bin/kafka-console-producer.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --property parse.key=true \
  --property key.separator=: <<EOF
1:{"atmid": 1, "transid": 106}
2:{"atmid": 2, "transid": 204}
EOF
