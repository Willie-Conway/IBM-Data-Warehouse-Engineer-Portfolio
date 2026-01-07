#!/bin/bash

# Exercise 4: Consume keyed messages with keys displayed

cd kafka_2.13-3.8.0

bin/kafka-console-consumer.sh \
  --bootstrap-server localhost:9092 \
  --topic bankbranch \
  --from-beginning \
  --property print.key=true \
  --property key.separator=:


# ✔ What You Will See

# Producer sends:

# 1:{"atmid":1,"transid":103}
# 1:{"atmid":1,"transid":104}
# 2:{"atmid":2,"transid":202}
# 2:{"atmid":2,"transid":203}
# 1:{"atmid":1,"transid":105}

# Consumer output will be grouped by key (ATM ID) in order:

# Partition 0 (key = 1)

# 1:{"atmid":1,"transid":103}
# 1:{"atmid":1,"transid":104}
# 1:{"atmid":1,"transid":105}


# Partition 1 (key = 2)

# 2:{"atmid":2,"transid":202}
# 2:{"atmid":2,"transid":203}