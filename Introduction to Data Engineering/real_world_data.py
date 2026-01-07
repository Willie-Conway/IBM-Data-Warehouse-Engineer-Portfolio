# Here’s an example using real-world data from the CORGIS “Cars” dataset, 
# featuring fuel (city & highway mpg) and vehicle specs. This Python program 
# demonstrates data wrangling steps—profiling, cleaning, normalizing, and 
# saving a cleaned version.

# 🗃️ Dataset
# We’re using the “Cars CSV File” from CORGIS, containing details like:

# Manufacturer, model year

# Engine specs: drivetrain, cylinders

# Fuel efficiency: city and highway mpg

# 🪢 Data Wrangling with Real Data

import pandas as pd

# Step 1: Load real-world data
df = pd.read_csv("cars.csv")

# Step 2: Preview & Profile the raw data
print("Initial preview:")
print(df.head(), "\n")

print("Column info:")
print(df.info(), "\n")

print("Missing values per column:")
print(df.isnull().sum(), "\n")

print("Duplicate rows:", df.duplicated().sum(), "\n")

# Step 3: Clean & wrangle the data

# Drop any completely empty rows
df = df.dropna(how="all")

# Fill missing fuel data with median values for their fuel type
for col in ["Fuel Information.City mpg", "Fuel Information.Highway mpg"]:
    med = df[col].median()
    df[col].fillna(med, inplace=True)

# Remove exact duplicates
df = df.drop_duplicates()

# Step 4: Normalize column names
df.columns = (
    df.columns
      .str.strip()
      .str.lower()
      .str.replace(' ', '_')
      .str.replace('.', '_')
)

# Step 5: Feature Engineering
# Calculate combined fuel efficiency
df["avg_mpg"] = (df["fuel_information_city_mpg"] + df["fuel_information_highway_mpg"]) / 2

# Tag efficient vehicles
df["efficient"] = df["avg_mpg"] > df["avg_mpg"].median()

# Step 6: Save the cleaned data
clean_file = "cars_cleaned.csv"
df.to_csv(clean_file, index=False)
print(f"✅ Cleaned data saved to '{clean_file}'")





# ✅ Highlights of This Program

# Profiling Data

# df.info(), missing/null checks, and duplicate detection

# Data Cleansing

# Dropping empty rows

# Imputing fuel data using median values

# Deduplication

# Removing exact duplicate rows

# Normalization

# Standardized column names for consistency

# Feature Engineering

# Created avg_mpg metric

# Tagged cars as efficient based on median avg_mpg

# Analytics‑Ready Output

# Result saved as cars_cleaned.csv, ready for analysis