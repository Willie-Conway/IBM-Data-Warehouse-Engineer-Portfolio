#!/bin/sh

# Define database
DATABASE=sakila

# Truncate all tables
mysql -Nse "SHOW TABLES" $DATABASE | \
while read table; do
    echo "Truncating $table..."
    mysql -e "USE $DATABASE; SET FOREIGN_KEY_CHECKS=0; TRUNCATE TABLE $table; SET FOREIGN_KEY_CHECKS=1;"
done

echo "✅ All tables truncated in database '$DATABASE'."


# Save as:

# /home/project/truncate.sh

# Make it executable:

# sudo chmod u+x+r /home/project/truncate.sh

# Run it:

# bash /home/project/truncate.sh


# Optional: Auto-Restore After Truncation
# You can modify the truncate script to also restore data from a SQL dump immediately after truncating:

# #!/bin/sh

# DATABASE=sakila

# DUMP_PATH="/home/project/sakila_mysql_dump.sql"

# # Truncate all tables
# mysql -Nse "SHOW TABLES" $DATABASE | \
# while read table; do
#     echo "Truncating $table..."
#     mysql -e "USE $DATABASE; SET FOREIGN_KEY_CHECKS=0; TRUNCATE TABLE $table; SET FOREIGN_KEY_CHECKS=1;"
# done

# # Restore from dump
# echo "Restoring database from $DUMP_PATH..."
# mysql $DATABASE < $DUMP_PATH

# echo "✅ Truncate and restore complete."