export PGPASSWORD=wWC2P0Pjfl6hTZ21VGdrPBvg
createdb -h postgres -U postgres -p 5432 storeDW




psql  
-h postgres -U postgres -p 5432 storeDW < sales-schema.sql