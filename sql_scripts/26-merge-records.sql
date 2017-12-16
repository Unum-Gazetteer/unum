/* Conflate places that have almost exactly same lat-long and are not places */
WITH conflated AS (
SELECT (
  SELECT ROW(
    longest(asciiname),
    uniq(alternate_names),
    uniq(attribution),
    longest(city),
    longest(county),
    longest(country),
    longest(country_code),
    max(dem),
    longest(display_name), /* should we recompute instead? */
    max(elevation),
    max(east),
    most_popular(geoname_feature_class), /* combine? */
    most_popular(geoname_feature_code), /* combine? */
    first(geonameid), /* combine? */
    first(geo_tag_id), /* combine? */
    most_popular(grid_cell_1_degree), /* recompute? */
    most_popular(grid_cell_5_degrees), /* recompute? */
    most_popular(grid_cell_10_degrees), /* recompute? */
    bool_or(has_admin_level),
    bool_or(has_population),
    max(importance),
    first(latitude), /* just pick first one.. really should do most popular */
    first(longitude), /* just pick first one */
    longest(name), /* should get most popular */
    longest(name_en), /* recalculate? */
    longest(name_en_unaccented), /* recalculate? */
    longest(normalized_name), /* recalculate? */
    max(north),
    most_popular(osmname_class), /* ?? */
    uniq(osmname_id), /* smash? */
    most_popular(osmname_type),
    most_popular(osm_type),
    first(osm_id),
    max(place_rank),
    most_popular(point), /* really should get closest to centroid */
    max(population),
    min(south),
    most_popular(state),
    most_popular(street),
    most_popular(timezone),
    min(west),
    uniq(wikidata),
    first(wikipageid),
    uniq(wikititle),
    uniq(wikiurl)
  )
  FROM places WHERE id = ANY(string_to_array(place_ids, ',')::int[])
)
FROM matches_within_11_meters LIMIT 2
)

SELECT row::places FROM conflated;



INSERT INTO places (asciiname, alternate_names, attribution, city, county, country, country_code, dem, display_name, elevation, east, geoname_feature_class, geoname_feature_code, geonameid, geo_tag_id, grid_cell_1_degree, grid_cell_5_degrees, grid_cell_10_degrees, has_admin_level, has_population, importance, latitude, longitude, name, name_en, name_en_unaccented, normalized_name, north, osmname_class, osmname_id, osmname_type, osm_type, osm_id, place_rank, point, population, south, state, street, timezone, west, wikidata, wikipageid, wikititle, wikiurl)

