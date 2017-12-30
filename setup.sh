sudo -u postgres psql -f sql_scripts/clear.sql
sudo -u postgres psql -f sql_scripts/initialize.sql

for file in sql_scripts/1-utils/*
do
    sudo -u postgres psql -f $file;
done  

for file in sql_scripts/2-convert/*
do
    sudo -u postgres psql -f $file;
done  
