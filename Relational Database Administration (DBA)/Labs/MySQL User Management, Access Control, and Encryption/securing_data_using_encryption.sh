#!/bin/bash

# MySQL connection parameters
HOST="localhost"      # Change to your host if needed
PORT="3306"
USER="root"           # Change as needed
PASSWORD="your_password"  # Change to your MySQL root or user password

# Passphrase for AES key
PASSPHRASE="My secret passphrase"

# Helper function to run MySQL commands
run_mysql() {
  mysql --host="$HOST" --port="$PORT" --user="$USER" --password="$PASSWORD" -N -B -e "$1"
}

echo "Step 1: Hash the passphrase with SHA2(512) and store in @key_str"
run_mysql "SET @key_str = SHA2('$PASSPHRASE', 512);"

echo "Step 2: Use customerorders database"
run_mysql "USE customerorders;"

echo "Step 3: Modify addressLine1 column to VARBINARY(255)"
run_mysql "ALTER TABLE customers MODIFY COLUMN addressLine1 VARBINARY(255);"

echo "Step 4: Encrypt addressLine1 column"
run_mysql "UPDATE customers SET addressLine1 = AES_ENCRYPT(addressLine1, @key_str);"

echo "Step 5: Display encrypted addressLine1 (first 5 rows)"
run_mysql "SELECT id, addressLine1 FROM customers LIMIT 5;"

echo "Step 6: Decrypt addressLine1 column to verify"
run_mysql "SELECT id, CAST(AES_DECRYPT(addressLine1, @key_str) AS CHAR(255)) AS addressLine1_decrypted FROM customers LIMIT 5;"

echo "Step 7: Modify cardNumber column in payments table to VARBINARY(255)"
run_mysql "ALTER TABLE payments MODIFY COLUMN cardNumber VARBINARY(255);"

echo "Step 8: Encrypt cardNumber column"
run_mysql "UPDATE payments SET cardNumber = AES_ENCRYPT(cardNumber, @key_str);"

echo "Step 9: Display encrypted cardNumber (first 5 rows)"
run_mysql "SELECT customerNumber, cardNumber FROM payments LIMIT 5;"

echo "Step 10: Decrypt cardNumber column to verify"
run_mysql "SELECT customerNumber, CAST(AES_DECRYPT(cardNumber, @key_str) AS CHAR(255)) AS cardNumber_decrypted FROM payments LIMIT 5;"

echo "✅ Encryption and decryption steps completed successfully."



# Notes:

# Replace your_password with your actual MySQL password.

# If your MySQL server is remote, update HOST accordingly.

# This script uses mysql CLI to execute commands.

# id and customerNumber columns are assumed present in customers and payments tables respectively. Adjust column names as needed.

# Run with: chmod +x encrypt_customerorders.sh && ./encrypt_customerorders.sh

