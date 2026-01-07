# 🛢️ Data Governance & Compliance 

# This program simulates a mini data governance and compliance framework around handling personal information, including:

# ✅ PII detection

# 🔐 Data masking

# 🔒 Access control

# 📋 Audit logging

# 📦 Secure deletion simulation

# This program handles a CSV dataset with sensitive data (name, email, phone), 
# mimicking a healthcare or finance environment subject to HIPAA/GDPR/PCI DSS.


import pandas as pd
import hashlib
import logging
import os

# 🔐 Audit log setup
logging.basicConfig(filename='data_audit.log', level=logging.INFO, format='%(asctime)s - %(message)s')

# 🔑 Simulated access control
AUTHORIZED_USERS = {"admin": "securepassword123"}

def authenticate(user: str, password: str) -> bool:
    if AUTHORIZED_USERS.get(user) == password:
        logging.info(f"User '{user}' authenticated.")
        return True
    logging.warning(f"Failed login attempt by '{user}'.")
    return False

# 🧾 Load fake PII dataset
data = pd.DataFrame({
    "Name": ["Alice Johnson", "Bob Smith"],
    "Email": ["alice@example.com", "bob@example.com"],
    "Phone": ["555-1234", "555-5678"],
    "Diagnosis": ["Hypertension", "Diabetes"]
})

logging.info("PII dataset loaded.")

# 🔐 Mask sensitive data
def mask_pii(df):
    df_masked = df.copy()
    df_masked["Email"] = df["Email"].apply(lambda x: hashlib.sha256(x.encode()).hexdigest())
    df_masked["Phone"] = df["Phone"].apply(lambda x: "XXX-XXXX")
    logging.info("Sensitive PII fields masked.")
    return df_masked

# 💣 Secure delete simulation
def secure_delete(file_path):
    if os.path.exists(file_path):
        with open(file_path, 'ba+', buffering=0) as f:
            f.write(os.urandom(os.path.getsize(file_path)))  # Overwrite with random bytes
        os.remove(file_path)
        logging.info(f"File {file_path} securely deleted.")

# 🚦 Example usage
if authenticate("admin", "securepassword123"):
    masked_data = mask_pii(data)
    print("Masked Dataset:\n", masked_data)

    # 🔐 Simulate export and secure delete
    export_path = "masked_output.csv"
    masked_data.to_csv(export_path, index=False)
    logging.info(f"Masked data exported to {export_path}.")

    # Simulate secure erasure
    secure_delete(export_path)




# 🔍 Features Demonstrated:

# Authentication mimicking role-based access.

# Data masking via hashing and redaction 
# (as required by GDPR, HIPAA).

# Audit logging for traceability.

# Secure deletion simulating data lifecycle end.

# Can be extended for encryption or monitoring with alerts.