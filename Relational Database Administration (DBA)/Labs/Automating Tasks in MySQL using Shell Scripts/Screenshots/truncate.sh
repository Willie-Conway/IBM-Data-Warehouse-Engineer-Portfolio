#!/bin/sh

DATABASE=sakila

# Get only base tables (exclude views)
mysql -Nse "SELECT table_name FROM information_schema.tables WHERE table_schema='$DATABASE' AND table_type='BASE TABLE';" | \
while read table; do
    mysql -e "USE $DATABASE; SET FOREIGN_KEY_CHECKS=0; TRUNCATE TABLE \`$table\`; SET FOREIGN_KEY_CHECKS=1;"
done


# Make it Executable and Run

# chmod +x truncate.sh

# ./truncate.sh