#download the data file
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/labs/Final%20Assignment/vehicle-data.csv
 
#download the sql file
 
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/labs/Final%20Assignment/setup.sql
 
#run the sql file
export PGPASSWORD="ew3kszV1FTSofxZVD3RTRh3n";
 
psql --username=postgres --host=postgres -f setup.sql
 
#import the csv file
 
cat vehicle-data.csv | psql --username=postgres -d tolldata --host=postgres -c "copy toll.tolldata from STDIN WITH (FORMAT csv);"
 
