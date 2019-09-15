# Update Package Lists
sudo apt-get update -qq

# Install Database Dependencies
sudo apt-get install -y postgresql postgresql-contrib postgresql-server-dev-all '^postgresql-[0-9].[0-9]-postgis-[0-9].[0-9]$'

# Install Other System Dependencies
sudo apt-get install -y build-essential git sudo unzip vim zip

# Restart PostgreSQL
sudo service postgresql restart

# Create Postgresql USER
sudo -u postgres psql -c "CREATE ROLE $(whoami) CREATEDB LOGIN SUPERUSER"
sudo -u postgres psql -c "CREATE DATABASE unum;"

# Download Safecast
cd /tmp && git clone https://github.com/DanielJDufour/safecast

# Install Safecast
cd /tmp/safecast && make install

# Initialize DB Extensions
psql -f sql_scripts/create_extensions.sql unum;

# Create PSQL Utils
for file in sql_scripts/1-utils/*; do
  psql -f $file unum;
done

# Create Custom Number Conversion Functions
for file in sql_scripts/2-convert/*; do
  psql -f $file unum;
done

# Create gazetteers Directory
if [ ! -d "/tmp/gazetteers" ] ; then
  mkdir /tmp/gazetteers;
fi;

# Download Gazetteer from Wikidata
if [ ! -f "/tmp/gazetteers/wikidata-gazetteer.tsv" ] ; then
  cd /tmp/gazetteers;
  wget https://s3.amazonaws.com/firstdraftgis/wikidata-gazetteer.tsv.zip;
  unzip wikidata-gazetteer.tsv.zip;
fi;

# Download OSMNames
if [ ! -f "/tmp/gazetteers/planet-latest_geonames.tsv" ] ; then
  cd /tmp/gazetteers;
  wget https://github.com/OSMNames/OSMNames/releases/download/v2.0.3/planet-latest_geonames.tsv.gz;
  gunzip planet-latest_geonames.tsv.gz;
fi;

# Download GeoNames
if [ ! -f "/tmp/gazetteers/allCountries.txt" ] ; then
  cd /tmp/gazetteers;
  wget http://download.geonames.org/export/dump/allCountries.zip;
  unzip allCountries.zip;
fi;  

# Copy Over Temp Files
cp data/* /tmp/.

# Load Gazetteers
for file in sql_scripts/5-load/*; do
  psql -f $file unum;
done

# Re-format Data from Gazetteers into Standard Format
for file in sql_scripts/10-conform/*; do
  psql -f $file unum;
done

# Conflate
for file in sql_scripts/20-conflate/*; do
  psql -f $file unum;
done

# Export
for file in sql_scripts/30-export/*; do
  psql -f $file unum;
done

# Sample
head -1 /tmp/unum.tsv > /tmp/unum_sample.tsv && time shuf -n 10000 /tmp/unum.tsv >> /tmp/unum_sample.tsv

# Install Pandas
pip install pandas --upgrade

# Test
python3 test.py

# Zip
cd /tmp && zip -r unum.tsv.zip unum.tsv
