INSERT INTO places
(admin1code, admin2code, admin3code, admin4code, admin_level, alternate_names, asciiname, astronomical_body, attribution, city, county, country, country_code, dem, display_name, elevation, east, geoname_feature_class, geoname_feature_code, geonameid, geo_tag_id, grid_cell_1_degree, grid_cell_5_degrees, grid_cell_10_degrees, has_admin_level, has_population, importance, latitude, longitude, name, name_en, name_en_unaccented, normalized_name, north, osmname_class, osmname_id, osmname_type, osm_id, place_rank, place_type, point, point_4, population, south, state, street, timezone, west, wikidata, wikipageid, wikititle, wikiurl, enwiki_title)
SELECT
    NULL AS admin1code,
    NULL AS admin2code,
    NULL AS admin3code,
    NULL AS admin4code,
    get_admin_level(type, to_integer(place_rank)) AS admin_level,
    alternative_names as alternate_names,
    get_ascii_name(name) as asciiname, /* returns null if conversion didn't work, which happens with Cryllic */
    'Earth' as astronomical_body,
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
    get_grid_cell(to_float(lat), to_float(lon), 1) AS grid_cell_1_degree,
    get_grid_cell(to_float(lat), to_float(lon), 5) AS grid_cell_5_degrees,
    get_grid_cell(to_float(lat), to_float(lon), 10) AS grid_cell_10_degrees,
    get_admin_level(type, to_integer(place_rank)) IS NOT NULL as has_admin_level,
    FALSE AS has_population,
    to_float(importance) as importance,
    to_float(lat) as latitude,
    to_float(lon) as longitude,
    name AS name,
    name AS name_en, /* name_en, Primary name in English ... need to find a better way of converting it.. but seems like osmanmes gives prominance to English */
    unaccent(name) AS name_en_unaccented, /* need to find a way to grab english name */
    lower(unaccent(replace(name, '.', ''))) as normalized_name,
    to_float(north) AS north,
    class as osmname_class,
    to_bigint(osm_id) AS osmname_id, /* osmname_id just use osm_id */
    type AS osmname_type,
    to_bigint(osm_id) as osm_id,
    to_integer(place_rank) AS place_rank,
    COALESCE((SELECT place_type FROM osm_class_to_place_type WHERE osm_class = class LIMIT 1)::varchar, (SELECT place_type FROM osm_type_to_place_type WHERE osm_type = type LIMIT 1)::varchar) as place_type,
    ST_SetSRID(ST_Point(to_float(lon), to_float(lat)), 4326) AS point,
    ST_SetSRID(ST_Point(round_to_4_decimals(lon), round_to_4_decimals(lat)), 4326) AS point_4,
    NULL AS population,
    to_float(south) AS south,
    state,
    street,
    NULL AS timezone, /* should probably create a function get_timezone that takes in lat lon and returns tz */
    to_float(west) as west,
    wikidata,
    NULL AS wikipageid,
    substring(wikipedia from position(':' in wikipedia) + 1) AS wikititle,
    wikipedia AS wikiurl,
    NULL AS enwiki_title
FROM osmnames;
