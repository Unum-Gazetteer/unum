INSERT INTO places
(admin1code, admin2code, admin3code, admin4code, admin_level, asciiname, alternate_names, attribution, city, county, country, country_code, dem, display_name, elevation, east, geoname_feature_class, geoname_feature_code, geonameid, geo_tag_id, grid_cell_1_degree, grid_cell_5_degrees, grid_cell_10_degrees, has_admin_level, has_population, importance, latitude, longitude, name, name_en, name_en_unaccented, normalized_name, north, osmname_class, osmname_id, osmname_type, osm_id, place_rank, point, population, south, state, street, timezone, west, wikidata, wikipageid, wikititle, wikiurl)
SELECT
    admin1_code AS admin1code,
    admin2_code AS admin2code,
    admin3_code AS admin3code,
    admin4_code AS admin4code,
    NULL AS admin_level,
    asciiname AS asciiname, /* returns null if conversion didn't work, which happens with Cryllic */
    alternatenames AS alternate_names,
    'GeoNames' AS attribution,
    NULL AS city,
    NULL AS county,
    NULL AS country,
    country_code,
    dem, /* dem */
    NULL AS display_name,
    elevation,
    NULL AS east,
    feature_class AS geoname_feature_class,
    feature_code AS geoname_feature_code,
    geonameid,
    NULL AS geo_tag_id, /* geo_tag_id -- could do a look up for each but would only be for English wikipedia??  */
    get_grid_cell(latitude, longitude, 1) AS grid_cell_1_degree,
    get_grid_cell(latitude, longitude, 5) AS grid_cell_5_degrees,
    get_grid_cell(latitude, longitude, 10) AS grid_cell_10_degrees,
    NULL as has_admin_level,
    population IS NOT NULL AND population > 0 AS has_population,
    NULL as importance,
    latitude,
    longitude,
    name AS name,
    name AS name_en, /* name_en, Primary name in English ... need to find a better way of converting it.. but seems like osmanmes gives prominance to English */
    unaccent(name) AS name_en_unaccented, /* need to find a way to grab english name */
    lower(unaccent(asciiname)) as normalized_name,
    NULL AS north,
    NULL as osmname_class,
    NULL AS osmname_id, /* osmname_id just use osm_id */
    NULL AS osmname_type,
    NULL as osm_id,
    get_place_rank_from_admin_level(NULL) AS place_rank,
    ST_SetSRID(ST_Point(longitude, latitude), 4326) AS point,
    population,
    NULL AS south,
    NULL AS state,
    NULL AS street,
    timezone, /* should probably create a function get_timezone that takes in lat lon and returns tz */
    NULL AS west,
    NULL AS wikidata,
    NULL AS wikipageid,
    NULL AS wikititle,
    NULL AS wikiurl
FROM geonames;
