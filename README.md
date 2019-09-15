![Unum Gazetteer](https://avatars3.githubusercontent.com/u/55306625?s=200&v=4)


# unum gazetteer
gazetteer that combines OSMNames, GeoNames and Wikidata.

# Download Link
https://s3.amazonaws.com/firstdraftgis/unum.tsv.zip

# Data License
The unum gazetteer is licensed under ODbL (the same as OSM). More discussion of the license is below.

# Columns (ordered alphabetically)
| column | description |
| -----  | ----------- |
| admin1code | Admin 1 Code (i.e. province or U.S. State) |
| admin2code | Admin 2 Code (i.e. district or California county) |
| admin3code | Admin 3 Code |
| admin4code | Admin 4 Code |
| admin_level | Admin Level |
| asciiname | Name converted into ascii encoding |
| alternate_names | Other names for this place |
| astronomical_body | name of planet, moon, or other body | Mars |
| attribution | Attribution to Geonames, OSM Contributors, and/or Wikidata |
| city | Name of City |
| county | Name of County |
| country | Name of Country |
| country_code | 2-3 Letter Country Code |
| dem | Digital Elevation Model from mostly GeoNames |
| display_name | Display Name from mostly OSMNames |
| elevation | Elevation from mostly GeoNames |
| east | Max Longitude |
| geoname_feature_class | GeoNames' Feature Class |
| geoname_feature_code | GeoNames' Feature Code |
| geonameid | GeoName ID |
| importance | OSMNames' Importance |
| latitude | Degrees North/South |
| longitude | Degrees East/West |
| name | Primary Name |
| name_en | Primary Name in English |
| north | Max Latitude  |
| osmname_class | OSMNames' Class |
| osmname_type | OSMNames' Type |
| osm_type | OSMNames' osm_type |
| osm_id | OSM ID |
| place_rank | OSMNames' Place Rank |
| place_type | Unum Place Type |
| population | Population from GeoNames and Wikidata |
| south | Min Latitude |
| state | State, mostly from OSMNames |
| street | Street, mostly from OSMNames |
| timezone | Timezone, mostly from GeoNames |
| wikidata_id | ID used by Wikidata, like Q142 |
| west | Min Longitude |
| enwiki_title | Title of English Wikipedia Page |

## Attribution
This gazetteer would not be possible without OpenStreetMap contributors, GeoNames, and Wikidata.  My heartfelt thanks to all.  Attribution is also provided for each place in 'attribution' column of the .tsv file.

## Data License

The actual gazetteer (i.e. .tsv file that you can download) is licensed under ODbL.  See below for a discussion of the licenses of the different data sources.

### OpenStreetMap
The license used by [OpenStreetMap](https://openstreetmap.org) is [Open Data Commons Open Database License (ODbL)](https://opendatacommons.org/licenses/odbl/). ODbL reqires that "If you alter or build upon our data, you may distribute the result only under the same licence".  Therefore, the data (i.e. the .tsv file you can download) is released under the same ODbL license.  We have provided attribution to 'OpenStreetMap Contributors' in the 'attribution' column.  You can read more here: http://www.openstreetmap.org/copyright

### GeoNames
[GeoNames](https://geonames.org) uses [Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/), which requires attribution.  We have made sure to provide attribution to GeoNames in the 'attribution' column.

### Wikidata
Although [Wikipedia](https://wikipedia.org) content appears to be available under different types of licenses, [Wikidata](https://www.wikidata.org/) (data derived from Wikipedia) is dedicated to the public domain under [CC0 1.0 Universal (CC0 1.0) Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/)

### Disclaimer
To the best of my ability, I have written this code and distributed this data in accordance with all licenses. If anyone has any questions or believe I have misinterpreted the licenses, please don't hesitate to contact me at daniel@firstdraftgis.com and I will address your concerns promptly.

# Contact
Feel free to post an issue or email Daniel J. Dufour at daniel.j.dufour@gmail.com
