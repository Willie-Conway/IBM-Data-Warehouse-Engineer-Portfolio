# 🧠 Data Platforms, Data Stores, and Security

# ✅ Key Concepts

# Data Platform Layers:

# Data Ingestion Layer: Collects data from sources.

# Data Storage & Integration Layer: Stores and merges data.

# Data Processing Layer: Validates and transforms data.

# Analysis & User Interface Layer: Presents data to users.

# Data Pipeline Layer: Ensures continuous data flow.

# Data Store Choice Depends On:

# Data type, volume, and use case.

# Scalability and performance requirements.

# Security, privacy, and governance policies.

# CIA Triad (Security Pillars):

# Confidentiality: Protect data access (e.g., encryption, access control).

# Integrity: Ensure data is accurate and untampered (e.g., hashing, validation).

# Availability: Ensure data is accessible when needed (e.g., backups, redundancy).


# 🔒 Secure Data Ingestion Pipeline

# This simplified Python example simulates:

# Confidentiality: Encrypts data before storage 
# (using symmetric encryption with cryptography lib)

# Integrity: Generates and verifies a hash checksum

# Availability: Simulates a backup step by copying data

# You can install dependencies via pip install cryptography


import json
import hashlib
import os
from cryptography.fernet import Fernet
import shutil

# Generate encryption key (usually stored securely and reused)
key = Fernet.generate_key()
cipher_suite = Fernet(key)

def encrypt_data(data_str):
    """Encrypt string data to bytes"""
    return cipher_suite.encrypt(data_str.encode())

def decrypt_data(encrypted_bytes):
    """Decrypt bytes back to string"""
    return cipher_suite.decrypt(encrypted_bytes).decode()

def hash_data(data_str):
    """Generate SHA256 hash of data"""
    return hashlib.sha256(data_str.encode()).hexdigest()

def save_data_securely(data, filename):
    """Simulate secure saving of data with encryption and integrity check"""
    # Convert data dict to JSON string
    json_data = json.dumps(data)

    # Encrypt data (Confidentiality)
    encrypted_data = encrypt_data(json_data)

    # Create hash for integrity check (Integrity)
    data_hash = hash_data(json_data)

    # Save encrypted data to file
    with open(filename, 'wb') as f:
        f.write(encrypted_data)
    
    # Save hash to a separate file
    with open(filename + ".hash", "w") as f_hash:
        f_hash.write(data_hash)

    print(f"Data saved securely to {filename}")

def verify_and_load_data(filename):
    """Verify data integrity and decrypt"""
    with open(filename, 'rb') as f:
        encrypted_data = f.read()

    with open(filename + ".hash", "r") as f_hash:
        stored_hash = f_hash.read()

    # Decrypt data
    decrypted_data = decrypt_data(encrypted_data)

    # Verify integrity
    current_hash = hash_data(decrypted_data)
    if current_hash == stored_hash:
        print("Integrity check passed!")
        return json.loads(decrypted_data)
    else:
        raise ValueError("Data integrity check failed! Possible tampering detected.")

def backup_data(src_filename, backup_filename):
    """Simulate availability by backing up the data file"""
    shutil.copy(src_filename, backup_filename)
    shutil.copy(src_filename + ".hash", backup_filename + ".hash")
    print(f"Backup created at {backup_filename}")

# Example usage
if __name__ == "__main__":
    # Sample data to ingest
    sample_data = {
        "user_id": 1234,
        "transaction": 250.75,
        "timestamp": "2025-06-15T18:00:00Z"
    }

    data_file = "secure_data.bin"
    backup_file = "secure_data_backup.bin"

    save_data_securely(sample_data, data_file)
    backup_data(data_file, backup_file)

    loaded_data = verify_and_load_data(data_file)
    print("Loaded Data:", loaded_data)


# 🔒 How This Maps to the CIA Triad

# | Security Pillar | Implementation                 | Description                                             |
# | --------------- | ------------------------------ | ------------------------------------------------------- |
# | Confidentiality | Encryption with `cryptography` | Data is stored encrypted to prevent unauthorized access |
# | Integrity       | SHA-256 hash check             | Detects tampering or corruption                         |
# | Availability    | File backup (simulated)        | Creates redundant copy to ensure data access            |
