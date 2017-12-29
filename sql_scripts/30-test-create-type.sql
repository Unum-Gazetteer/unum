CREATE TYPE test_item AS (
    name text
);

/* Conflate places that have almost exactly same lat-long and are not places */
WITH conflated AS (
SELECT (
  SELECT ROW(
    longest(name)
  )
  FROM places WHERE id = ANY(string_to_array(place_ids, ',')::int[])
)
FROM matches_within_11_meters LIMIT 2
)

SELECT row::text FROM conflated;


/*INSERT INTO places (asciiname, alternate_names, attribution, city, county, country, country_code, dem, display_name, elevation, east, geoname_feature_class, geoname_feature_code, geonameid, geo_tag_id, grid_cell_1_degree, grid_cell_5_degrees, grid_cell_10_degrees, has_admin_level, has_population, importance, latitude, longitude, name, name_en, name_en_unaccented, normalized_name, north, osmname_class, osmname_id, osmname_type, osm_type, osm_id, place_rank, point, population, south, state, street, timezone, west, wikidata, wikipageid, wikititle, wikiurl)*/
