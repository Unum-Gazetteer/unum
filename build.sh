# exit on the first error found
set -o errexit

echo "Set Source Code Directory"
UNUM_SRC_DIR=$(pwd)
echo "Set Source Code Directory to $UNUM_SRC_DIR"

echo "Installing sudo"
apt-get install sudo

echo "Install Other System Dependencies"
sudo apt-get install -y build-essential git sudo unzip vim zip

echo "Update Package Lists"
sudo apt-get update -qq

echo "search for PostGIS packages"
apt-cache search postgis

echo "Install Database Dependencies"
sudo apt-get install -y postgresql postgresql-contrib postgresql-server-dev-all '^postgresql-[1-9][0-9](.[0-9])*-postgis-[0-9](.[0-9])*$'

echo "Restart PostgreSQL"
sudo service postgresql restart

echo "Create Postgresql USER"
sudo -u postgres psql -c "CREATE ROLE $(whoami) CREATEDB LOGIN SUPERUSER"
sudo -u postgres psql -c "CREATE DATABASE unum;"

echo "Download Safecast"
git clone https://github.com/DanielJDufour/safecast /tmp/safecast

echo "Install Safecast"
cd /tmp/safecast && make install

echo "Initialize DB Extensions"
psql -f sql_scripts/create_extensions.sql unum;

echo "return to unum source code directory"
cd $UNUM_SRC_DIR

echo "Create PSQL Utils"
for file in ${UNUM_SRC_DIR}/sql_scripts/1-utils/*; do
  psql -f $file unum;
done

echo "Create Custom Number Conversion Functions"
for file in ${UNUM_SRC_DIR}/sql_scripts/2-convert/*; do
  psql -f $file unum;
done

echo "Create gazetteers Directory"
if [ ! -d "/tmp/gazetteers" ] ; then
  mkdir /tmp/gazetteers;
fi;

echo "Download Gazetteer from Wikidata"
if [ ! -f "/tmp/gazetteers/wikidata-gazetteer.tsv" ] ; then
  cd /tmp/gazetteers;
  wget --quiet https://s3.amazonaws.com/firstdraftgis/wikidata-gazetteer.tsv.zip;
  unzip wikidata-gazetteer.tsv.zip;
fi;

echo "Download OSMNames"
if [ ! -f "/tmp/gazetteers/planet-latest_geonames.tsv" ] ; then
  cd /tmp/gazetteers;
  wget --quiet https://github.com/OSMNames/OSMNames/releases/download/v2.0.3/planet-latest_geonames.tsv.gz;
  gunzip planet-latest_geonames.tsv.gz;
fi;

echo "Download GeoNames"
if [ ! -f "/tmp/gazetteers/allCountries.txt" ] ; then
  cd /tmp/gazetteers;
  wget --quiet http://download.geonames.org/export/dump/allCountries.zip;
  unzip allCountries.zip;
fi;

echo "Copy Over Temp Files"
cp ${UNUM_SRC_DIR}/data/* /tmp/.

echo "Load Gazetteers"
for file in ${UNUM_SRC_DIR}/sql_scripts/5-load/*; do
  psql -f $file unum;
done

echo "Re-format Data from Gazetteers into Standard Format"
for file in ${UNUM_SRC_DIR}/sql_scripts/10-conform/*; do
  psql -f $file unum;
done

echo "Conflate"
for file in ${UNUM_SRC_DIR}/sql_scripts/20-conflate/*; do
  psql -f $file unum;
done

echo "Export"
for file in ${UNUM_SRC_DIR}/sql_scripts/30-export/*; do
  psql -f $file unum;
done

echo "Sample"
head -1 /tmp/unum.tsv > /tmp/unum_sample.tsv && time shuf -n 10000 /tmp/unum.tsv >> /tmp/unum_sample.tsv

echo "Install Pandas"
pip install pandas --upgrade

echo "Test"
cd $UNUM_SRC_DIR && python3 test.py

echo "Zip"
cd /tmp && zip -r unum.tsv.zip unum.tsv
