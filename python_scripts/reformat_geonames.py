from csv import reader
from csv import writer
from csv import QUOTE_ALL

from utils import get_grid_cell

infile_path = "/tmp/gazetteers/allCountries.txt"
infile = open(infile_path)
reader = reader(infile, delimiter="\t")

outfile_path = "/tmp/geonames-conformed.txt"
outfile = open(outfile_path, "w")
writer = writer(outfile, delimiter="\t", quoting=QUOTE_ALL)

count = 0    
for line in reader:
    count += 1
    geonameid, name, asciiname, alternatenames, latitude, longitude, feature_class, feature_code, country_code, cc2, admin1_code, admin2_code, admin3_code, admin4_code, population, elevation, dem, timezone, modification_date = line
        
    print("geonameid:", geonameid)
      
    attribution = "GeoNames"    


    writer.writerow([
        admin1_code,
        admin2_code,
        admin3_code,
        admin4_code,
        "",
        asciiname,
        alternatenames,
        attribution,
        "",
        "",
        "",
        country_code,
        dem,
        "",
        elevation,
        "",
        feature_class,
        feature_code,
        geonameid,
        "",
        
    ])

      
    if count >= 100:
        break