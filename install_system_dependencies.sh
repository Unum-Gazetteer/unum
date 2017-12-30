sudo apt-get install binutils


sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
sudo apt update 
sudo apt upgrade # if you already have gdal 1.11 installed 
sudo apt install gdal-bin 


# install reqs for imposm
sudo apt install build-essential python-dev protobuf-compiler libprotobuf-dev libtokyocabinet-dev python-psycopg2 libgeos-c1

sudo apt install osm2pgsql

echo "INSTALLING SYSTEM PACKAGES"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confnew" install apache2 apache2-dev apt-file build-essential cmake curl cython cython3 default-jdk default-jre fabric firefox gcc gfortran git libapache2-mod-wsgi libatlas-base-dev libblas3 libblas-dev liblapack-dev libboost-all-dev libc6 libcgal-dev libgeos-dev libgmp3-dev liblapack3 libmpfr-dev libmpfr-doc libmpfr4 libmpfr4-dbg libopenblas-dev libproj-dev libpq-dev mariadb-server maven osmctools postgresql postgresql-contrib postgresql-server-dev-all  '^postgresql-[0-9].[0-9]-postgis-[0-9].[0-9]$' python python3-venv python-dev python-letsencrypt-apache python-pip python-qgis python-virtualenv qgis subversion vim xvfb zip libxslt1-dev
