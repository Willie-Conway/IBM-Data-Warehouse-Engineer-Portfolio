#!/bin/bash

# Exercise 3: Consumer for bankbranch topic
cd kafka_2.13-3.8.0

bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --from-beginning


# Producer output

# Sends:

# {"atmid":1,"transid":100}
# {"atmid":1,"transid":101}
# {"atmid":2,"transid":200}
# {"atmid":1,"transid":102}
# {"atmid":2,"transid":201}