# 🔒 Data Platform Layers + CIA Security

# This illustrates a simple multi-layer data platform pipeline covering:


# Data Ingestion

# Data Storage & Integration

# Data Processing


# Analysis & User Interface

# Data Pipeline orchestration

# and demonstrates the CIA triad (Confidentiality, Integrity, Availability) applied on the stored data.


import json
import hashlib
import os
import shutil
from cryptography.fernet import Fernet
import time

# === Security Setup ===
# Generate encryption key for confidentiality
ENCRYPTION_KEY = Fernet.generate_key()
cipher = Fernet(ENCRYPTION_KEY)

# File paths
DATA_FILE = "data_store.bin"
HASH_FILE = "data_store.hash"
BACKUP_FILE = "data_store_backup.bin"
BACKUP_HASH_FILE = "data_store_backup.hash"


# === Layer 1: Data Ingestion ===
def ingest_data():
    # Simulated ingestion from multiple sources
    print("[Ingestion] Collecting data...")
    data = [
        {"id": 101, "event": "login", "user": "alice", "timestamp": "2025-06-15T12:00:00Z"},
        {"id": 102, "event": "purchase", "user": "bob", "amount": 59.99, "timestamp": "2025-06-15T12:05:00Z"},
        {"id": 103, "event": "logout", "user": "alice", "timestamp": "2025-06-15T12:10:00Z"}
    ]
    return data


# === Layer 2: Data Storage & Integration ===
def store_data(data):
    print("[Storage] Encrypting and storing data...")
    json_str = json.dumps(data)
    encrypted_data = cipher.encrypt(json_str.encode('utf-8'))
    
    # Write encrypted data
    with open(DATA_FILE, "wb") as f:
        f.write(encrypted_data)

    # Create hash for integrity check
    data_hash = hashlib.sha256(json_str.encode('utf-8')).hexdigest()
    with open(HASH_FILE, "w") as f:
        f.write(data_hash)
    print("[Storage] Data stored with integrity hash.")

    # Create backup (Availability)
    shutil.copy(DATA_FILE, BACKUP_FILE)
    shutil.copy(HASH_FILE, BACKUP_HASH_FILE)
    print("[Storage] Backup created for availability.")


# === Layer 3: Data Processing ===
def process_data():
    print("[Processing] Loading and validating data...")
    # Load encrypted data
    with open(DATA_FILE, "rb") as f:
        encrypted_data = f.read()
    
    # Decrypt
    decrypted_json = cipher.decrypt(encrypted_data).decode('utf-8')

    # Verify integrity
    with open(HASH_FILE, "r") as f:
        stored_hash = f.read()

    computed_hash = hashlib.sha256(decrypted_json.encode('utf-8')).hexdigest()
    if stored_hash != computed_hash:
        raise Exception("Data integrity check failed! Data may be corrupted or tampered with.")
    
    # Convert JSON to Python list
    data = json.loads(decrypted_json)

    # Apply simple business rule: mark purchases above $50 as 'high_value'
    for record in data:
        if record.get("event") == "purchase" and record.get("amount", 0) > 50:
            record["high_value"] = True
        else:
            record["high_value"] = False

    print("[Processing] Data validated and business rules applied.")
    return data


# === Layer 4: Analysis & User Interface ===
def analyze_and_display(data):
    print("\n[Analysis & UI] Presenting processed data:")
    for record in data:
        print(record)


# === Layer 5: Data Pipeline ===
def run_pipeline():
    print("Starting Data Platform Pipeline...\n")
    raw_data = ingest_data()
    store_data(raw_data)
    processed_data = process_data()
    analyze_and_display(processed_data)
    print("\nData Platform Pipeline completed successfully.")

if __name__ == "__main__":
    run_pipeline()



#  📘What this example shows:

# | Component                      | Description                                                                                                      |
# | ------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
# | **Data Ingestion**             | Simulates collecting raw event data                                                                              |
# | **Data Storage & Integration** | Encrypts and stores data securely, generates SHA256 hash to ensure integrity, and backs up data for availability |
# | **Data Processing**            | Decrypts data, verifies integrity via hash, and applies a business rule                                          |
# | **Analysis & UI**              | Displays the processed data records with applied rules                                                           |
# | **Data Pipeline**              | Orchestrates the entire workflow                                                                                 |
# | **Security (CIA Triad)**       |                                                                                                                  |


# Confidentiality: Encryption using symmetric key (Fernet)

# Integrity: SHA-256 hash verification

# Availability: Backup file creation 