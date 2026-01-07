#!/bin/bash
# Script: generate_report.sh
# Description: Parses a CSV file, creates a new column with computed values, and generates a new report

csv_file="./arrays_table.csv"

# Step 1: Parse table columns into 3 arrays
column_0=($(cut -d "," -f 1 "$csv_file"))
column_1=($(cut -d "," -f 2 "$csv_file"))
column_2=($(cut -d "," -f 3 "$csv_file"))

# Display first column as a quick validation
echo "📊 Displaying the first column:"
echo "${column_0[@]}"

# Step 2: Create a new array (column_3) with the difference between column_2 and column_1
column_3=("column_3")  # Header for the new column

# Get number of lines (including header)
nlines=$(wc -l < "$csv_file")
echo "📄 There are $nlines lines in the file (including header)"

# Populate column_3 with the computed differences
for ((i=1; i<nlines; i++)); do
  column_3[$i]=$((column_2[$i] - column_1[$i]))
done

# Show new column for verification
echo "➕ New column values:"
echo "${column_3[@]}"

# Step 3: Create a new CSV report with the added column
output_file="report.csv"

# Write header of new column
echo "${column_3[0]}" > column_3.txt

# Write values to new column_3.txt line by line
for ((i=1; i<nlines; i++)); do
  echo "${column_3[$i]}" >> column_3.txt
done

# Merge original CSV and new column into final report
paste -d "," "$csv_file" column_3.txt > "$output_file"

# Clean up
rm column_3.txt

# Confirm report generation
echo "✅ Report generated: $output_file"


# How to use:

# Save the script:

# nano generate_report.sh

# Paste the script, then save with Ctrl+O, Enter, and exit with Ctrl+X.

# Make it executable:

# chmod +x generate_report.sh

# Ensure the CSV file exists:

# If not already downloaded:

# wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/M3/L2/arrays_table.csv
# Run the script:

# ./generate_report.sh