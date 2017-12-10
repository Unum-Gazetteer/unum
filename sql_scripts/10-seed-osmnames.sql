INSERT INTO places
(admin1code, admin2code, admin3code, admin4code, admin_level, asciiname, alternate_names, attribution, city, county, country, country_code, dem, display_name, elevation, east, geoname_feature_class, geoname_feature_code, geonameid, geo_tag_id, importance, latitude, longitude, name, name_en, name_en_unaccented, normalized_name, north, osmname_class, osmname_id, osmname_type, osm_id, place_rank, point, population, south, state, street, timezone, west, wikidata, wikipageid, wikititle, wikiurl)
SELECT
    NULL AS admin1code,
    NULL AS admin2code,
    NULL AS admin3code,
    NULL AS admin4code,
    get_admin_level(type, to_integer(place_rank)) AS admin_level,
    get_ascii_name(name) as asciiname, /* returns null if conversion didn't work, which happens with Cryllic */
    alternative_names as alternate_names,
    '(Copyright) OpenStreetMap contributors' AS attribution,
    city,
    county,
    country,
    country_code,
    NULL AS dem, /* dem */
    display_name,
    NULL AS elevation, /* elevation */
    to_float(east) as east,
    NULL AS geoname_feature_class, /* geoname_feature_class */
    NULL AS geoname_feature_code, /* geoname feature_code */
    NULL AS geonameid, /* geoname id */
    NULL AS geo_tag_id, /* geo_tag_id -- could do a look up for each but would only be for English wikipedia??  */
    to_float(importance) as importance,
    to_float(lat) as latitude,
    to_float(lon) as longitude,
    name AS name,
    name AS name_en, /* name_en, Primary name in English ... need to find a better way of converting it.. but seems like osmanmes gives prominance to English */
    unaccent(name) AS name_en_unaccented, /* need to find a way to grab english name */
    lower(unaccent(name)) as normalized_name,
    to_float(north) AS north,
    class as osmname_class,
    to_bigint(osm_id) AS osmname_id, /* osmname_id just use osm_id */
    type AS osmname_type,
    to_bigint(osm_id) as osm_id,
    to_integer(place_rank) AS place_rank,
    ST_SetSRID(ST_Point(to_float(lon), to_float(lat)), 4326) AS point,
    NULL AS population,
    to_float(south) AS south,
    state,
    street,
    NULL AS timezone, /* should probably create a function get_timezone that takes in lat lon and returns tz */
    to_float(west) as west,
    wikidata,
    NULL AS wikipageid,
    substring(wikipedia from position(':' in wikipedia) + 1) AS wikititle,
    wikipedia AS wikiurl
FROM osmnames;
