/*
postgres=# select ARRAY(SELECT DISTINCT * FROM unnest(string_to_array(string_agg(alternate_names, ','), ',')) ORDER BY 1) from places WHERE normalized_name = 'portland' GROUP BY normalized_name LIMIT 3;
*/
CREATE OR REPLACE FUNCTION uniquify(input text)
RETURNS text AS $$
    SELECT array_to_string(ARRAY(SELECT DISTINCT * FROM unnest(string_to_array(input, ',')) ORDER BY 1), ',');
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION
conflate_places(place_ids_as_string text)
RETURNS void AS $$
BEGIN
    RAISE NOTICE 'conflating';
END;
$$
LANGUAGE PLPGSQL;

/*SELECT conflate_places(place_ids) FROM matches_within_11_meters LIMIT 10;*/


/* Conflate places that have almost exactly same lat-long and are not places */
INSERT INTO places (asciiname, alternate_names, attribution, city, county, country, country_code, dem, display_name, elevation, east, geoname_feature_class, geoname_feature_code, geonameid, geo_tag_id, grid_cell_1_degree, grid_cell_5_degrees, grid_cell_10_degrees, has_admin_level, has_population, importance, latitude, longitude, name, name_en, name_en_unaccented, normalized_name, north, osmname_class, osmname_id, osmname_type, osm_type, osm_id, place_rank, point, population, south, state, street, timezone, west, wikidata, wikipageid, wikititle, wikiurl)
SELECT
    asciiname varchar(2000),
    uniquify(string_agg(alternate_names, ','))
    uniquify(string_agg(attribution, ','))
    city,
    county,
    country,
    country_code,
    max(dem),
    display_name, /* should we recompute display names or really take the longest one? */
    max(elevation),
    max(east),
    geoname_feature_class, /* should I really smash into one ? */
    geoname_feature_code, /* should I really smash into one ? */
    geonameid, /* conflating into one.. wonder if I should store multiple?? */
    geo_tag_id, /* conflating into one.. is that a good idea? */
    grid_cell_1_degree, /* should we combine?.. will make lookups harder, but more correct .. or at least recalculate */
    grid_cell_5_degrees,
    grid_cell_10_degrees,
    CAST(max(CAST(has_admin_level AS int)) AS bool),
    CAST(max(CAST(has_population AS int)) AS bool),
    max(importance),
    latitude, /* just pick first one.. really should do most popular */
    longitude, /* just pick first one */
    name, /* should get most popular */
    name_en, /* shoudl get more popular */
    name_en_unaccented, /* should get most popular */
    normalized_name, /* shoudl recalculate */
    max(north),
    osmname_class,
    osmname_id, /* smash? */
    osmname_type, /* could say multiple right? */
    osm_type, /* smash? */
    osm_id, /* should I smash? */
    max(place_rank),
    point geometry(Point,4326), /* really should get closest to centroid */
    max(population),
    min(south),
    state,
    street,
    timezone,
    west,
    wikidata,
    wikipageid,
    wikititle,
    wikiurl
)
